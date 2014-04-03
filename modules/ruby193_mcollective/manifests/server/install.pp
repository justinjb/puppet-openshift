class ruby193_mcollective::server::install {

	include "::ruby193_mcollective::install"

	realize(
		Package["ruby193-mcollective-client"]
	)

}

