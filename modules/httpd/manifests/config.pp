class httpd::config {

        include "httpd::install"

        File {
                require                 => Class["httpd::install"]
        }

        file { "/etc/httpd/conf.d/ssl.conf":
                source                  => "puppet:///modules/httpd/etc/httpd/conf.d/ssl.conf"
        }

}

