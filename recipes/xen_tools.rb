#
# Cookbook Name:: xen
# Recipe:: xen_tools
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

include_recipe "xen"
package "xen-tools"

template "/etc/xen-tools/xen-tools.conf" do
  source "xen-tools.conf.erb"
  owner "root"
  group "root"
  mode 0644
end

if !node[:xen][:xen_tools][:directory].empty? && node[:xen][:xen_tools][:volume_group].empty?
  directory node[:xen][:xen_tools][:directory] do
    owner "root"
    group "root"
    mode 0755
  end
end
