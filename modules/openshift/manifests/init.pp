class openshift {

	include "::openshift::broker"
	include "::openshift::node"
	include "::openshift::bsn"
}

class openshift::broker { 

	include "::openshift::broker::install"
	include "::openshift::broker::config"
	include "::openshift::broker::service"

	include "::openshift::console"

        include "::ruby193_mcollective::client::install"
        include "::ruby193_mcollective::client::config"
        include "::openshift::broker::service"
        include "::httpd"
        include "::openshift::broker::selinux"
        include "::selinux"
	include "::ntp"
	
        Class["::ruby193_mcollective::client::install"] -> Class["openshift::broker::config"]
        Class["openshift::broker::install"] -> Class["openshift::broker::config"]
        Class["openshift::broker::config"] -> Class["openshift::broker::service"]


}

class openshift::console {

	include "::openshift::console::config"
	include "::openshift::console::install"
	include "::openshift::console::service"

}



class openshift::bsn {

	include "::openshift::bsn::config"
	include "::openshift::bsn::service"
	include "::openshift::bsn::install"
	include "::ntp"

        $openshift_data                         = hiera('openshift_data')
	$openshift_activemq_user		= $openshift_data['activemq_user']
	$openshift_activemq_pass		= $openshift_data['activemq_pass']
	$openshift_activemq_topic		= $openshift_data['activemq_topic']

	# Use puppetlabs' provided activemq module
        class { 'activemq':
		users => [ [ $openshift_activemq_user, $openshift_activemq_pass, $openshift_activemq_topic ] ],
#                users   => [ [ 'mcollective', 'marionette', 'foo1topic' ] ],
                activemq_peers => [ [ 'peer1', 'peer1user', 'peer1pass' ] ]
        }

}

class openshift::node {

	include "openshift::node::config"
	include "openshift::node::service"
	include "openshift::node::install"
	include "openshift::node::exec"
	include "cgroups"
	include "ntp"
	include "oddjob"
	include "pam"

	Class["pam"]				-> Class["openshift::node::service"]
	Class["openshift::node::install"]	-> Class["openshift::node::config"]
	Class["cgroups"]			-> Class["openshift::node::config"]
	Class["openshift::node::config"]	-> Class["openshift::node::service"]

}
