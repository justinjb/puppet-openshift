class openshift::node::install { 

	Package {
		ensure				=> latest
	}

	package { "rubygem-openshift-origin-node":
	}

	package { "ruby193-rubygem-passenger-native":
	}

	package { "openshift-origin-node-util":
	}

	package { "rubygem-openshift-origin-container-selinux":
	}

	package { "rubygem-openshift-origin-frontend-nodejs-websocket":
	}

	package { "rubygem-openshift-origin-frontend-apache-mod-rewrite":
	}

	package { "openshift-origin-msg-node-mcollective":
	}

}
