node "broker01.openshift06.home.lab.dtrainor.local" {
	include "openshift::broker"
	include "openshift::console"
}

node "bsn01.openshift06.home.lab.dtrainor.local" {
	include "openshift::bsn"
}

node "node01.openshift06.home.lab.dtrainor.local" {
	include "openshift::node"
}

node "node02.openshift06.home.lab.dtrainor.local" {
	include "openshift::node"
}

node "node03.openshift06.home.lab.dtrainor.local" {
	include "openshift::node"
}
