class mongodb::install {

	include "mongodb::service"

	package { "mongodb":
		ensure				=> latest,
		notify				=> Class["mongodb::service"]
	}

	package { "mongodb-server":
		ensure				=> latest,
		notify				=> Class["mongodb::service"]
	}

}
