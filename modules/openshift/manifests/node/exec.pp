class openshift::node::exec {

        exec { "node restorecon":
                command                         => '/sbin/restorecon -r /var/lib/openshift /etc/openshift/node.conf /etc/httpd/conf.d/openshift',
                refreshonly                     => true
        }

}

