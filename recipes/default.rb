#
# Cookbook Name:: xen
# Recipe:: default
#
# Copyright 2010, Divergent Logic, LLC
#
# All rights reserved - Do Not Redistribute
#

package "xen-hypervisor-amd64"
package "xen-utils"
package "xenstore-utils"
package "xen-linux-system" if platform?("debian")

template "/etc/xen/xend-config.sxp" do
  source "xend-config.sxp.erb"
  owner "root"
  group "root"
  mode 0644
end

# Resolved a issue with Debian 5.X (Lenny) and Xen 3 clocksource/0 error.
# See http://wiki.debian.org/Xen/Clocksource for more information
if node[:platform] == "debian" && node[:platform_version].to_i >= 5
  template "/etc/modprobe.d/netloop" do
    source "netloop.erb"
    owner "root"
    group "root"
    mode 0644
  end
  
  template "/etc/sysctl.d/xen.conf" do
    source "xen.conf.erb"
    owner "root"
    group "root"
    mode 0644
  end
end
