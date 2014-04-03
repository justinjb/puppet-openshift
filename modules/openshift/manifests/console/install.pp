class openshift::console::install {

	include "::openshift::console::service"

	Package { 
		notify				=> Class["openshift::console::service"]
	}

	package { "openshift-origin-console":
		ensure				=> latest
	}

}
