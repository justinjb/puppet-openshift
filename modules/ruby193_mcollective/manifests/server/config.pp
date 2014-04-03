class ruby193_mcollective::server::config {

        $openshift_data                         = hiera('openshift_data')
        $openshift_activemq_host                = $openshift_data['activemq_host']
        $openshift_activemq_user                = $openshift_data['activemq_user']
        $openshift_activemq_pass                = $openshift_data['activemq_pass']
        $openshift_activemq_port                = $openshift_data['activemq_port']
        $openshift_activemq_topic               = $openshift_data['activemq_topic']

	file { "/opt/rh/ruby193/root/etc/mcollective/server.cfg":
		content					=> template("ruby193_mcollective/opt/rh/ruby193/root/etc/mcollective/server.cfg.erb"),
	}

	file { "/opt/rh/ruby193/root/etc/mcollective/client.cfg":
		ensure					=> absent
	}

}
