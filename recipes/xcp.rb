include_recipe "xen"

package "xcp-xapi" if platform?("ubuntu")
