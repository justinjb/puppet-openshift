class openshift::node::config {

	include "::ruby193_mcollective::server"
	include "::modprobe"
	include "::httpd"
	include "::openshift::node::service"
	include "::selinux"

	Class["modprobe"] -> Class["openshift::node::config"]
	Class["::selinux"] -> Class["openshift::node::service"]
	Class["ruby193_mcollective::server"] -> Class["openshift::node::config"]



        $openshift_cloud_domain                 = hiera('openshift_data::cloud_domain')
        $openshift_gear_min_uid                 = hiera('openshift_data::gear_min_uid')
        $openshift_gear_max_uid                 = hiera('openshift_data::gear_max_uid')
        $openshift_broker_host                  = hiera('openshift_data::broker_host')



	file { "/etc/httpd/conf.d/000001_openshift_origin_node_servername.conf":
		content				=> template("openshift/etc/httpd/conf.d/000001_openshift_origin_node_servername.conf.erb"),
		notify				=> Class["httpd::service"]
	}

	file { "/etc/openshift/node.conf":
		content				=> template("openshift/etc/openshift/node.conf.erb"),
		notify				=> Class["openshift::node::service"]
	}

	file { "/opt/rh/ruby193/root/usr/share/gems/gems/openshift-origin-node-1.17.5.11/lib/openshift-origin-node/utils/tc.rb":
		source				=> "puppet:///modules/openshift/opt/rh/ruby193/root/usr/share/gems/gems/openshift-origin-node-1.17.5.11/lib/openshift-origin-node/utils/tc.rb",
	}


        selinux::boolean { "httpd_unified":
                value                           => on,
        }
        selinux::boolean { "httpd_can_network_connect":
                value                           => on,
        }
        selinux::boolean { "httpd_can_network_relay":
                value                           => on,
        }

        selinux::boolean { "httpd_read_user_content":
                value                           => on,
        }

        selinux::boolean { "httpd_enable_homedirs":
                value                           => on,
        }

        selinux::boolean { "httpd_run_stickshift":
                value                           => on,
        }

        selinux::boolean { "allow_polyinstantiation":
                value                           => on,
        }







  exec { 'Initialize quota DB':
    command => '/usr/sbin/oo-init-quota',
    require => Package['openshift-origin-node-util'],
    path    => ['/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    unless  => '/usr/bin/quota -f $(df /var/lib/openshift/ | tail -1 | tr -s \' \' | cut -d\' \' -f 6 | sort -u) -q 2>/dev/null',
  }

  augeas { 'Tune Sysctl knobs':
    context  => "/files/etc/sysctl.conf",
    changes  => [
      # Increase kernel semaphores to accomodate many httpds.
      "set kernel.sem '250  32000 32  4096'",

      # Move ephemeral port range to accommodate app proxies.
      "set net.ipv4.ip_local_port_range '15000 35530'",

      #IPTables port proxy
      "set net.ipv4.ip_forward 1",
      "set net.ipv4.conf.all.route_localnet 1",

      #Shared memory limits
      "set kernel.shmall 4294967296",
      "set kernel.shmmax 68719476736",

      #IPC Message queue limits
      "set kernel.msgmnb 65536",
      "set kernel.msgmax 65536",
    ],
    notify  => Exec['Reload sysctl'],
  }

	# Reload sysctl.conf to get the new settings.
	#
	# Note: We could add -e here to ignore errors that are caused by
	# options appearing in sysctl.conf that correspond to kernel modules
	# that are not yet loaded.  On the other hand, adding -e might cause
	# us to miss some important error messages.
	exec{ 'Reload sysctl':
		command     => "/sbin/sysctl -p /etc/sysctl.conf",
		path		=> "/sbin",
		refreshonly => true,
	}


}
