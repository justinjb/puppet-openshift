class openshift::broker::selinux {

	include "::selinux"

        @selinux::boolean { "httpd_unified":
                value                           => on,
		tag				=> ['broker']
        }

	@selinux::boolean { "httpd_execmem":
		value				=> on,
		tag                             => ['broker']
	}

	@selinux::boolean { "httpd_can_network_connect":
		value				=> on,
		tag                             => ['broker']
	}

	@selinux::boolean { "httpd_can_network_relay":
		value				=> on,
		tag                             => ['broker']
	}

	@selinux::boolean { "httpd_read_user_content":
		value				=> on,
		tag                             => ['broker']
	}

	@selinux::boolean { "httpd_enable_homedirs":
		value				=> on,
		tag                             => ['broker']
	}

	@selinux::boolean { "httpd_run_stickshift":
		value				=> on,
		tag                             => ['broker']
	}

	@selinux::boolean { "allow_polyinstantiation":
		value				=> on,
		tag                             => ['broker']
	}

	@selinux::boolean { "allow_ypbind":
		value				=> on,
		tag                             => ['broker']
	}

	@selinux::boolean { "named_write_master_zones":
		value				=> on,
		tag                             => ['broker']
	}

}
