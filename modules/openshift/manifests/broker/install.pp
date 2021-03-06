class openshift::broker::install {

	include "::httpd"
	include "::openshift::broker::service"
	include "::ruby193_mcollective::client"

	Class["ruby193_mcollective::client"] -> Class["openshift::broker::install"]

	Package { 
		ensure				=> latest,
		require				=> Class["httpd"],
		notify				=> Class["openshift::broker::service"]
	}

	package { "openshift-origin-broker":
	}

	package { "openshift-origin-broker-util":
	}

	package { "rubygem-openshift-origin-auth-remote-user":
	}

	package { "rubygem-openshift-origin-msg-broker-mcollective":
	}

	package { "rubygem-openshift-origin-dns-nsupdate":
	}

}

