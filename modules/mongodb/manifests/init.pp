class mongodb { 

	include "mongodb::config"
	include "mongodb::service"
	include "mongodb::install"

	mongob::user { "foo":
		password			=> "bar"
	}

}
