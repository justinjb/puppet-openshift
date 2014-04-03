class ruby193_mcollective::client {

	include "::ruby193_mcollective::client::config"
	include "::ruby193_mcollective::client::install"
	include "::ruby193_mcollective::install"

        include "::openshift::broker::service"

       Class["ruby193_mcollective::client::install"] -> Class["ruby193_mcollective::client::config"]


}

class ruby193_mcollective::server {

	include "ruby193_mcollective::server::install"
	include "ruby193_mcollective::server::config"
	include "ruby193_mcollective::server::service"

	Class["ruby193_mcollective::server::install"] -> Class["ruby193_mcollective::server::config"] -> Class["ruby193_mcollective::server::service"]

}

class ruby193_mcollective::install {

	@package { "ruby193-mcollective-client":
		ensure					=> latest
	}

}

