class dantest (
	$users 		= [ [ 'mcoprod',	'mcoprodpass',	'mcoprod' ], 
			    [ 'mcodev',		'mcodevpass', 'aasdsadasd'],
			    [ 'mcostg',		'mcostgpass',	'mcostg' ]
			],
	$activemq_peers	= [ [ 'activemq-peer-01.domain.tld',	'peer01username',	'peer01password' ],
			    [ 'activemq-peer-02.domain.tld',	'peer02username',	'peer02password' ],
			    [ 'activemq-peer-03.domain.tld',	'peer03username',	'peer03password' ]
			],
	)
{
	file { "/tmp/activemq.xml":
		content			=> template("dantest/activemq.xml.erb")
	}


}
