class openshift::bsn::config {

	include "mongodb::config"

	Class["mongodb::config"] -> Class["openshift::bsn::config"]

}
