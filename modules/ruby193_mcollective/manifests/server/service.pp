class ruby193_mcollective::server::service {

#	include "::ruby193_mcollective::server::config"
#	include "::ruby193_mcollective::server::install"

	Class["ruby193_mcollective::server::config"] -> Class["ruby193_mcollective::server::service"]

	service { "ruby193-mcollective":
		ensure					=> running,
		enable					=> true,
		subscribe				=> Class["ruby193_mcollective::server::config", "ruby193_mcollective::server::install"]
	}

}
