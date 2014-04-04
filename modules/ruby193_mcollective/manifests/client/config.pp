class ruby193_mcollective::client::config {

	
#       $openshift_activemq_host                = $::openshift::broker::config::['openshift_data']['activemq_host']
        $openshift_activemq_host                = hiera('openshift_data::activemq_host')
        $openshift_activemq_user                = hiera('openshift_data::activemq_user')
        $openshift_activemq_pass                = hiera('openshift_data::activemq_pass')
        $openshift_activemq_port                = hiera('openshift_data::activemq_port')
        $openshift_activemq_topic               = hiera('openshift_data::activemq_topic')

#        $openshift_activemq_host                = $::openshift::broker::config::openshift_data::activemq_host
#        $openshift_activemq_user                = $::openshift::broker::config::openshift_data::activemq_user
#        $openshift_activemq_pass                = $::openshift::broker::config::openshift_data::activemq_pass
#        $openshift_activemq_port                = $::openshift::broker::config::openshift_data::activemq_port
#        $openshift_activemq_topic               = $::openshift::broker::config::openshift_data::activemq_topic



	file { "/opt/rh/ruby193/root/etc/mcollective/client.cfg":
		content					=> template("ruby193_mcollective/opt/rh/ruby193/root/etc/mcollective/client.cfg.erb"),
		notify					=> Class["::openshift::broker::service"]
	}

}
