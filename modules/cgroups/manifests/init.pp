# Copyright 2013 Mojo Lingo LLC.
# Modifications by Red Hat, Inc.
# 
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
# 
#      http://www.apache.org/licenses/LICENSE-2.0
# 
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
#

class cgroups {

	include "::cgroups::config"
	include "::cgroups::exec"
	include "::cgroups::service"
	include "::cgroups::install"

}

class cgroups::config {

	file { "/etc/cgconfig.conf":
		source				=> "puppet:///modules/cgroups/etc/cgconfig.conf",
		notify				=> Class["cgroups::exec"],
		replace				=> false
	}

}

class cgroups::exec {

	exec { "cgroups prepare":
		command				=> '/sbin/restorecon -rv /etc/cgconfig.conf; mkdir -p /cgroup; restorecon -rv /cgroup',
		refreshonly			=> true
	}

}

class cgroups::service {

	Service {
		subscribe			=> Class["cgroups::config", "cgroups::exec", "cgroups::install"]
	}

	service { "cgconfig":
		enable				=> true,
		ensure				=> running
	}

	service { "cgred":
		enable				=> true,
		ensure				=> running
	}

}

class cgroups::install {

	package { "libcgroup":
		ensure				=> latest,
	}

	package { "libcgroup-pam":
		ensure				=> latest,
	}

}	

