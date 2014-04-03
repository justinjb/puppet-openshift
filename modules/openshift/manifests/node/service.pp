class openshift::node::service {

	include "::openshift::node::config"

	Class["openshift::node::config"] -> Class["openshift::node::service"]

	service { "openshift-node-web-proxy":
		ensure				=> running,
		enable				=> true
	}

	service { "openshift-gears":
		ensure				=> running,
		enable				=> true
	}

}
