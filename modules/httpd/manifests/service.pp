class httpd::service {

        Service {
                require                         => Class["httpd::config"]
        }

        service { "httpd":
                ensure                  => running,
                enable                  => true
        }

}
