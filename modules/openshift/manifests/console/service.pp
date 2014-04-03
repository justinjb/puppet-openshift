class openshift::console::service {

	include "::openshift::console::config"

	Class["openshift::console::config"] -> Class["openshift::console::service"]
	
	service { "openshift-console":
		enable				=> true,
		ensure				=> running
	}

}
