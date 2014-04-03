class openshift::broker::service {

	include "::httpd::config"
	include "::openshift::broker::selinux"

	Service { 
		require				=> Class[ "httpd::config", "openshift::broker::selinux"]
	}

	service { "openshift-broker":
		ensure				=> running,
		enable				=> true,
	}

}
