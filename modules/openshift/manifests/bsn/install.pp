class openshift::bsn::install {

	include "mongodb::install"

	Class["mongodb::install"] -> Class["openshift::bsn::install"]

}
