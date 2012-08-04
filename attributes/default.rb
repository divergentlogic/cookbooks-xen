# It is normally much better to create the bridge yourself in
# /etc/network/interfaces.  network-bridge start does nothing if you
# already have a bridge, and network-bridge stop does nothing if the
# default bridge name (normally eth0) is not a bridge.  See
# bridge-utils-interfaces(5) for full information on the syntax in
# /etc/network/interfaces, but you probably want something like this:
#    iface xenbr0 inet static
#        address [etc]
#        netmask [etc]
#        [etc]
#        bridge_ports eth0
default[:xen][:network_script] = 'network-bridge'

# The script used to control virtual interfaces.  This can be overridden on a
# per-vif basis when creating a domain or a configuring a new vif.  The
# vif-bridge script is designed for use with the network-bridge script, or
# similar configurations.
#
# If you have overridden the bridge name using
# (network-script 'network-bridge bridge=<name>') then you may wish to do the
# same here.  The bridge name can also be set when creating a domain or
# configuring a new vif, but a value specified here would act as a default.
#
# If you are using only one bridge, the vif-bridge script will discover that,
# so there is no need to specify it explicitly.  The default is to use
# the bridge which is listed first in the output from brctl.


default[:xen][:vif_script] = 'vif-bridge'
# default[:xen][:vif_script] = 'vif-route'
# default[:xen][:vif_script] = 'vif-nat'


# dom0-min-mem is the lowest permissible memory level (in MB) for dom0.
# This is a minimum both for auto-ballooning (as enabled by
# enable-dom0-ballooning below) and for xm mem-set when applied to dom0.
default[:xen][:dom0_min_mem] = "196"

#  Output directory for storing loopback images.
#
# If you choose to use loopback images, which are simple to manage but
# slower than LVM partitions, then specify a directory here and uncomment
# the line.
#
# New instances will be stored in subdirectories named after their
# hostnames.
default[:xen][:xen_tools][:directory] = "/home/xen"

# If you don't wish to use loopback images then you may specify an 
# LVM volume group here instead
default[:xen][:xen_tools][:volume_group] = ""

# Default distro to install
default[:xen][:xen_tools][:distribution] = "`xt-guess-suite-and-mirror --suite`"

# Disk, Memory and Swap options
default[:xen][:xen_tools][:memory] = "768Mb"
default[:xen][:xen_tools][:swap] = "1.5Gb"
default[:xen][:xen_tools][:disk_size] = "20Gb"

# new instances static IP addresses.
default[:xen][:xen_tools][:gateway] = "192.168.0.1"
default[:xen][:xen_tools][:netmask] = "255.255.255.0"
default[:xen][:xen_tools][:broadcast] = "192.168.0.255"

# interactively setup a new root password for images.
default[:xen][:xen_tools][:passwd] = 0

# Default kernel and ramdisk to use for the virtual servers
default[:xen][:xen_tools][:kernel] = "/boot/vmlinuz-`uname -r`"
default[:xen][:xen_tools][:initrd] = "/boot/initrd.img-`uname -r`"

# The default mirror for debootstrap to install Debian-derived distributions
default[:xen][:xen_tools][:mirror] = "`xt-guess-suite-and-mirror --mirror`"

if node[:platform] == "debian" && node[:platform_version].to_i >= 5
  #  If you're using the lenny or later version of the Xen guest kernel you will
  # need to make sure that you use 'hvc0' for the guest serial device,
  # and 'xvdX' instead of 'sdX' for serial devices.
  default[:xen][:xen_tools][:serial_device] = "hvc0"
  default[:xen][:xen_tools][:disk_device] = "xvda"
  default[:xen][:xen_tools][:arch] = "amd64"
  default[:xen][:xen_tools][:role] = "udev"

  default[:xen][:tuning][:netloop] = '32'
  default[:xen][:tuning][:independent_wallclock] = "1"
end