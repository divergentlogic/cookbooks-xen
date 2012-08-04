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
