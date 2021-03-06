class openshift::console::config {

	include "::openshift::console::service"

	File {
		notify				=> Class["openshift::console::service"]
	}

	file { "/etc/openshift/console.conf":
		content				=> template("openshift/etc/openshift/console.conf.erb"),
	}

	file { "/var/www/openshift/console/httpd/conf.d/openshift-origin-auth-remote-user-basic.conf":
		source                          => "puppet:///modules/openshift/var/www/openshift/console/httpd/conf.d/openshift-origin-auth-remote-user-basic.conf",
		notify                          => Class["openshift::broker::service"]
	}

	exec { "console ssl certs":
		command				=> "/usr/bin/openssl req -subj '/CN=$fqdnl/O=$fqdn/C=US' -nodes -new -newkey rsa:2048 -keyout /etc/pki/tls/private/localhost.key -x509 -days 3650 -out /etc/pki/tls/certs/localhost.crt",
		creates				=> ["/etc/pki/tls/private/localhost.key", "/etc/pki/tls/certs/localhost.crt"]
	}

}
