maintainer       "Divergent Logic, LLC"
maintainer_email "ops@divergenltogic.com"
license          "Apache 2.0"
description      "Installs and configures Xen"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "0.0.3"
recipe            "xen", "Includes the recipe to install the hypervisor and utilities"
recipe            "xen::xen_tools", "Installs xen tools. Utilites to create new VM's"
recipe            "xen::xcp", "Installs Xen Cloud Platform."
recipe            "xen::xenwatch", "Installs xenwatch. A tool to monitor xen"

supports "debian"
supports "ubuntu"
