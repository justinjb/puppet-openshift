class openshift::bsn::service {

	include "mongodb::service"

	Class["mongodb::service"] -> Class["openshift::bsn::service"]

}
