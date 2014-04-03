class ntp::service {

	include "ntp::config"

	Class["ntp::config"] -> Class["ntp::service"]

	service { "ntpd":
		ensure				=> running,
		enable				=> true
	}

}
