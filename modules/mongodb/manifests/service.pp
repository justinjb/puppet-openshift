class mongodb::service {

	Class["mongodb::config"] -> Class["mongodb::service"]

	service { "mongod":
		ensure				=> running,
		enable				=> true
	}

}
