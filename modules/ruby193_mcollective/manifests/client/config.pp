class ruby193_mcollective::client::config {

        $openshift_data                         = hiera('openshift_data')
        $openshift_activemq_host                = $openshift_data['activemq_host']
        $openshift_activemq_user                = $openshift_data['activemq_user']
        $openshift_activemq_pass                = $openshift_data['activemq_pass']
        $openshift_activemq_port                = $openshift_data['activemq_port']
        $openshift_activemq_topic               = $openshift_data['activemq_topic']

	file { "/opt/rh/ruby193/root/etc/mcollective/client.cfg":
		content					=> template("ruby193_mcollective/opt/rh/ruby193/root/etc/mcollective/client.cfg.erb"),
		notify					=> Class["::openshift::broker::service"]
	}

}
