#
# Cookbook Name:: xen
# Recipe:: default
#
# Copyright 2012, Divergent Logic, LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

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
