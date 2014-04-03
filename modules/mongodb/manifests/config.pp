class mongodb::config { 

	Class["mongodb::install"] -> Class["mongodb::config"]

	include "mongodb::service"

	file { "/etc/mongodb.conf":
		content				=> template("mongodb/etc/mongodb.conf.erb"),
		notify				=> Class["mongodb::service"]
	}	
	
}
