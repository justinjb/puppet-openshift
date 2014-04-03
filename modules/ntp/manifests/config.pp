class ntp::config {

	include "ntp::install"
	include "ntp::service"

	Class["ntp::install"] -> Class["ntp::config"]

	file { "/etc/ntp.conf":
		content					=> template("ntp/etc/ntp.conf.erb"),
		notify					=> Class["ntp::service"]
	}

}
