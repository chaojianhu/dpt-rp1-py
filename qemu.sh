#!/bin/bash

#qemu-img create -f raw _xpsp3.raw 12G
#qemu-img create -f raw _debian.raw 8G
#qemu-img create -f qcow2 _xpsp3.qcow2 12G
#qemu-img create -f qcow2 _debian.qcow2 8G

#qemu-img create -f qcow2 debian1.qcow2 -o backing_file=debian.qcow2 6G
#qemu-img create -f qcow2 debian2.qcow2 -o backing_file=debian.qcow2 6G

#-cdrom /home/thinkpad/system/windowsxp_professional_sp3.iso
#-cdrom /home/thinkpad/system/debian-7.7.0-i386-DVD-1.iso
#-cdrom /home/fiks-hu/system/windowsxp_professional_sp3.iso
#-cdrom /home/fiks-hu/system/debian-7.7.0-i386-DVD-1.iso
#-cdrom /home/xw/system/windowsxp_professional_sp3.iso
#-cdrom /home/xw/system/debian-7.7.0-i386-DVD-1.iso

#sudo tunctl -t tap0 -u thinkpad
#sudo tunctl -t tap0 -u fiks-hu
#sudo tunctl -t tap0 -u xw
#sudo tunctl -d tap0

#sudo brctl addbr br0
#sudo brctl addif br0 eth0
#sudo brctl addif br0 tap0

#sudo /etc/init.d/networking start
#sudo ifconfig xx up/down

# host-only
# sudo tunctl -t tap0 -u fiks-hu (host)
# sudo ifconfig tap0 172.16.0.1 netmask 255.255.0.0 up (host)
# sudo ifconfig eth0 172.16.0.2 netmask 255.255.0.0 up (guest)
# sudo route add default gw 172.16.0.1 (guest) 

# bridge
# sudo tunctl -t tap0 -u fiks-hu (host)
# sudo brctl addif xenbr0 tap0 (host)
# sudo ifconfig tap0 0.0.0.0 up (host)
# sudo ifconfig eth0 192.168.168.203 netmask 255.255.0.0 up (guest)
# sudo route add default gw 192.168.168.1 (guest) 

# nat
# sudo tunctl -t tap0 -u fiks-hu (host)
# sudo brctl addif xenbr0 tap0 (host)
# sudo ifconfig tap0 0.0.0.0 up (host)
# sudo echo 1 > /proc/sys/net/ipv4/ip_forward (host)
# sudo iptables -t nat -A POSTROUTING -o wlan0 -j MASQUERADE (host)
# sudo iptables -t filter -A FORWARD -i wlan0 -j ACCEPT (host)
# sudo ifconfig eth0 192.168.168.25 netmask 255.255.255.0 up (guest)
# sudo route add default gw 192.168.168.1 (guest) 
# sudo vim /etc/resolv.conf
# nameserver 192.168.168.1

#sudo iptables -t nat -A POSTROUTING -s "192.168.168.0/255.255.255.0" ! -d "192.168.168.0/255.255.255.0" -j MASQUERADE
#sudo iptables -t filter -A FORWARD -s "192.168.168.0/255.255.255.0" ! -d "192.168.168.0/255.255.255.0" -j ACCEPT

#sudo iptables -t nat -A POSTROUTING -s "192.168.168.0/255.255.255.0" ! -d "192.168.168.0/255.255.255.0" -o wlan0 -j MASQUERADE
#sudo iptables -t filter -A FORWARD -s "192.168.168.0/255.255.255.0" ! -d "192.168.168.0/255.255.255.0" -i wlan0 -j ACCEPT

#dnsmasq --strict-order --except-interface=lo --interface=br0 --listen-address=192.168.168.1 --bind-interfaces --dhcp-range=192.168.168.200,192.168.168.220 --conf-file="" --pid-file=/var/run/qemu-dhcp-br0.pid --dhcp-leasefile=/var/run/qemu-dhcp-br0.leases --dhcp-no-override

#macaddr parameter is needed for inter-connection between VMs
#qemu-system-x86_64 -enable-kvm -m 1024 -usb -usbdevice tablet -net nic,macaddr=00:11:22:33:44:66 -net tap,ifname=tap0,script=no,downscript=no centos.qcow2
#qemu-system-x86_64 -enable-kvm -m 1024 -usb -usbdevice tablet -net nic,macaddr=00:11:22:33:44:88 -net tap,ifname=tap1,script=no,downscript=no ubuntu.qcow2

#-curses
#-display curses

#-sdl
#-display sdl

#-vnc :7
#-disaply vnc=:7

#-nographic
#-vnc :7 -nographic

#-spice port=4000,password=123456 -nographic
#-vga vmware -spice port=4000,password=123456 -nographic
#-vga qxl -spice port=4000,password=123456 -nographic

#-chardev spicevmc,name=usbredir,id=usbredirchardev1 -device usb-redir,chardev=usbredirchardev1,id=usbredirdev1
#-chardev spicevmc,name=usbredir,id=usbredirchardev2 -device usb-redir,chardev=usbredirchardev2,id=usbredirdev2
#-chardev spicevmc,name=usbredir,id=usbredirchardev3 -device usb-redir,chardev=usbredirchardev3,id=usbredirdev3

#spicy -h 192.168.168.112 -p 4000 -w 123456 #operate the input memu in gui

#-chardev socket,id=usbredirchardev1,path=/var/run/usb-simu/simu1 -device usb-redir,chardev=usbredirchardev1,id=usbredirdev1
#-chardev socket,id=usbredirchardev1,path=/var/run/usb-simu/simu1,server,nowait -device usb-redir,chardev=usbredirchardev1,id=usbredirdev1
#run usb-simu to connect to or listen on unix socket /var/run/usb-simu/simu1

#-monitor stdio
#-monitor telnet::5437,server,nowait

#-usb
#-usbdevice tablet
#-device usb-tablet 
#-usbdevice disk:format=raw:flp.img
#-drive if=none,file=flp.img,id=my_usb_drive -device usb-storage,drive=my_usb_drive,id=my_usb_device,removable=on

#drive_add 0 if=none,file=flp.img,id=my_usb_drive
#device_add usb-storage,id=my_usb_device,drive=my_usb_drive
#device_del my_usb_device

#-redir tcp:2222::22

#-balloon virtio
#-device virtio-balloon-pci

#-vga virtio
#-device virtio-vga,vectors=2

#-net nic,model=virtio,macaddr=52:54:00:ce:61:04 -net user

#-net nic,model=virtio,macaddr=52:54:00:ce:61:04 -net tap,ifname=tap1,script=no,downscript=no
#-netdev tap,id=tapnet,ifname=tap1,script=no,downscript=no -net nic,netdev=tapnet,model=virtio,macaddr=52:54:00:ce:61:04
#-netdev tap,id=tapnet,ifname=tap1,script=no,downscript=no -device virtio-net-pci,netdev=tapnet,mac=52:54:00:ce:61:04

#-netdev tap,id=tapnet,ifname=tap1,script=no,downscript=no -device virtio-net-pci,netdev=tapnet,mac=52:54:00:ce:61:04,vectors=3

#-drive file=xpsp3.qcow2,if=none,id=xpsp3 -device virtio-blk-pci,drive=xpsp3,vectors=4
#-drive file=xpsp3.qcow2,if=virtio,id=xpsp3,vectors=4
#-drive file=xpsp3.qcow2,if=virtio,vectors=4

#-device virtio-gpu-pci,vectors=5

# host
#-fsdev local,id=test_dev,path=/home/fiks-hu/book,security_model=none -device virtio-9p-pci,fsdev=test_dev,mount_tag=test_mount
#-virtfs local,id=test_dev,path=/home/fiks-hu/book,security_model=none,mount_tag=test_mount
#guest
#modprobe 9p
#mount -t 9p -o trans=virtio test_mount /home/debian/work/mnt -oversion=9p2000.L

#-mem-path /dev/hugepages -mem-prealloc
#-object memory-backend-file,id=mem,size=1024M,mem-path=/dev/hugepages,share=on -numa node,memdev=mem -mem-prealloc

#-fda flp.img
#-gdb tcp::1234
#-cpu host,+rdrand 

#-kernel vmlinux
#-kernel vmlinux.bin
#-kernel bzImage 
#-kernel arch/x86/boot/bzImage

#-kernel vmlinuz-3.2.0
#-initrd initrd.img-3.2.0
#-append root=/dev/sda

#QEMUBIN=/home/thinkpad/qemu-debug/i386-softmmu/qemu-system-i386
QEMUBIN=/home/thinkpad/qemu-debug/x86_64-softmmu/qemu-system-x86_64

#QEMUBIN=qemu-system-i386
#QEMUBIN=qemu-system-x86_64

#QEMUBIN=qemu-kvm
#QEMUBIN=kvm
#QEMUBIN=/usr/libexec/qemu-kvm

#-vga vmware
#-device vmware-svga

#vmware-svga.rombar=uint32
#vmware-svga.x-pcie-lnksta-dllla=bool (on/off)
#vmware-svga.multifunction=bool (on/off)
#vmware-svga.romfile=str
#vmware-svga.vgamem_mb=uint32
#vmware-svga.x-pcie-extcap-init=bool (on/off)
#vmware-svga.command_serr_enable=bool (on/off)
#vmware-svga.addr=int32 (Slot and optional function number, example: 06.0 or 06)


# debian tap/e1000
#${QEMUBIN} -enable-kvm -m 1024 -monitor telnet::5437,server,nowait -vnc :7 -nographic -usb -device usb-tablet -net nic,model=e1000,macaddr=52:54:00:ce:61:04 -net tap,ifname=tap1,script=no,downscript=no -hda debian.qcow2 2>&1 | tee qemu-run.log.txt
#/home/thinkpad/qemu-debug/x86_64-softmmu/qemu-system-x86_64 -enable-kvm -m 1024 -monitor telnet::5437,server,nowait -vnc :7 -nographic -usb -device usb-tablet -net nic,model=e1000,macaddr=52:54:00:ce:61:04 -net tap,ifname=tap1,script=no,downscript=no -hda debian.qcow2 2>&1 | tee qemu-run.log.txt

# debian tap/e1000e
${QEMUBIN} -smp 2 -enable-kvm -m 1024 -device vmware-svga,rombar=0 -monitor telnet::5437,server,nowait -vnc :7 -nographic -usb -device usb-tablet -netdev tap,id=tapnet,ifname=tap0,script=no,downscript=no -device e1000e,netdev=tapnet,mac=52:54:00:ce:61:04 -hda debian.qcow2 2>&1 | tee qemu-run.log.txt
#/home/thinkpad/qemu-debug/x86_64-softmmu/qemu-system-x86_64 -smp 2 -enable-kvm -m 1024 -device vmware-svga,rombar=0 -monitor telnet::5437,server,nowait -vnc :7 -nographic -usb -device usb-tablet -netdev tap,id=tapnet,ifname=tap0,script=no,downscript=no -device e1000e,netdev=tapnet,mac=52:54:00:ce:61:04 -hda debian.qcow2 2>&1 | tee qemu-run.log.txt

#tap-script-helper
#${QEMUBIN} -enable-kvm -m 1024 -monitor telnet::5437,server,nowait -vnc :7 -nographic -usb -usbdevice tablet -net nic,model=virtio,macaddr=52:54:00:ce:61:04 -net tap,script=no,downscript=no -hda debian.qcow2
#${QEMUBIN} -enable-kvm -m 1024 -monitor telnet::5437,server,nowait -vnc :7 -nographic -usb -usbdevice tablet -net nic,model=virtio,macaddr=52:54:00:ce:61:04 -net tap,ifname=tap0,script=no,downscript=no -hda debian.qcow2
#${QEMUBIN} -enable-kvm -m 1024 -monitor telnet::5437,server,nowait -vnc :7 -nographic -usb -usbdevice tablet -net nic,model=virtio,macaddr=52:54:00:ce:61:04 -net tap,script=/etc/qemu-ifup,downscript=/etc/qemu-ifdown -hda debian.qcow2
#${QEMUBIN} -enable-kvm -m 1024 -monitor telnet::5437,server,nowait -vnc :7 -nographic -usb -usbdevice tablet -net nic,model=virtio,macaddr=52:54:00:ce:61:04 -net tap,ifname=tap0,script=/etc/qemu-ifup,downscript=/etc/qemu-ifdown -hda debian.qcow2
#${QEMUBIN} -enable-kvm -m 1024 -monitor telnet::5437,server,nowait -vnc :7 -nographic -usb -usbdevice tablet -net nic,model=virtio,macaddr=52:54:00:ce:61:04 -net tap,helper=/usr/local/libexec/qemu-bridge-helper -hda debian.qcow2
#${QEMUBIN} -enable-kvm -m 1024 -monitor telnet::5437,server,nowait -vnc :7 -nographic -usb -usbdevice tablet -net nic,model=virtio,macaddr=52:54:00:ce:61:04 -net tap,ifname=tap0,helper=/usr/local/libexec/qemu-bridge-helper -hda debian.qcow2

#pci-assign
#${QEMUBIN} -enable-kvm -m 1024 -monitor stdio -usb -usbdevice tablet -device pci-assign,host=00:19.0 -net none -hda debian.qcow2
#${QEMUBIN} -enable-kvm -m 1024 -monitor telnet::5437,server,nowait -vnc :7 -nographic -usb -usbdevice tablet -device pci-assign,host=00:19.0 -net none -hda debian.qcow2

#vfio-pci
#${QEMUBIN} -enable-kvm -m 1024 -monitor stdio -usb -usbdevice tablet -device vfio-pci,host=00:19.0 -net none -hda debian.qcow2
#${QEMUBIN} -enable-kvm -m 1024 -monitor telnet::5437,server,nowait -vnc :7 -nographic -usb -usbdevice tablet -device vfio-pci,host=00:19.0 -net none -hda debian.qcow2

#debian vhost-user,user/virtio/hostfwd
#${QEMUBIN} -smp 2 -enable-kvm -m 1024 -monitor stdio -usb -usbdevice tablet -chardev socket,id=char0,path=/var/run/openvswitch/vhost-user1 -netdev vhost-user,id=mynet1,chardev=char0,vhostforce -device virtio-net-pci,netdev=mynet1,mac=52:54:00:02:d9:02 -object memory-backend-file,id=mem,size=1024M,mem-path=/dev/hugepages,share=on -numa node,memdev=mem -mem-prealloc -net nic,model=virtio,macaddr=52:54:00:ce:61:04 -net user,hostfwd=tcp::10022-:22 -hda debian.qcow2
#${QEMUBIN} -smp 2 -enable-kvm -m 1024 -monitor telnet::5437,server,nowait -vnc :7 -nographic -usb -usbdevice tablet -chardev socket,id=char0,path=/var/run/openvswitch/vhost-user1 -netdev vhost-user,id=mynet1,chardev=char0,vhostforce -device virtio-net-pci,netdev=mynet1,mac=52:54:00:02:d9:02 -object memory-backend-file,id=mem,size=1024M,mem-path=/dev/hugepages,share=on -numa node,memdev=mem -mem-prealloc -net nic,model=virtio,macaddr=52:54:00:ce:61:04 -net user,hostfwd=tcp::10022-:22 -hda debian.qcow2

#debian vhost-user/multiqueue,user/virtio/hostfwd
#${QEMUBIN} -smp 2 -enable-kvm -m 1024 -monitor stdio -usb -usbdevice tablet -chardev socket,id=char0,path=/var/run/openvswitch/vhost-user1 -netdev vhost-user,id=mynet1,chardev=char0,vhostforce,queues=5 -device virtio-net-pci,netdev=mynet1,mac=52:54:00:02:d9:02,mq=on,vectors=12 -object memory-backend-file,id=mem,size=1024M,mem-path=/dev/hugepages,share=on -numa node,memdev=mem -mem-prealloc -net nic,model=virtio,macaddr=52:54:00:ce:61:04 -net user,hostfwd=tcp::10022-:22 -hda debian.qcow2
#${QEMUBIN} -smp 2 -enable-kvm -m 1024 -monitor telnet::5437,server,nowait -vnc :7 -nographic -usb -usbdevice tablet -chardev socket,id=char0,path=/var/run/openvswitch/vhost-user1 -netdev vhost-user,id=mynet1,chardev=char0,vhostforce,queues=5 -device virtio-net-pci,netdev=mynet1,mac=52:54:00:02:d9:02,mq=on,vectors=12 -object memory-backend-file,id=mem,size=1024M,mem-path=/dev/hugepages,share=on -numa node,memdev=mem -mem-prealloc -net nic,model=virtio,macaddr=52:54:00:ce:61:04 -net user,hostfwd=tcp::10022-:22 -hda debian.qcow2

# xp user/virtio
#${QEMUBIN} -enable-kvm -m 1024 -monitor stdio -usb -usbdevice tablet -net nic,model=virtio,macaddr=52:54:00:ce:61:04 -net user -hda xpsp3.qcow2
#${QEMUBIN} -enable-kvm -m 1024 -monitor telnet::5437,server,nowait -vnc :7 -nographic -usb -usbdevice tablet -net nic,model=virtio,macaddr=52:54:00:ce:61:04 -net user -hda xpsp3.qcow2

# debian user/virtio
#${QEMUBIN} -enable-kvm -m 1024 -monitor stdio -usb -usbdevice tablet -net nic,model=virtio,macaddr=52:54:00:ce:61:04 -net user -hda debian.qcow2
#${QEMUBIN} -enable-kvm -m 1024 -monitor telnet::5437,server,nowait -vnc :7 -nographic -usb -usbdevice tablet -net nic,model=virtio,macaddr=52:54:00:ce:61:04 -net user -hda debian.qcow2

#xp user/virtio/hostfwd
#${QEMUBIN} -smp 2 -enable-kvm -m 1024 -monitor stdio -usb -usbdevice tablet -net nic,model=virtio,macaddr=52:54:00:ce:61:04 -net user,hostfwd=tcp::10022-:22 -hda xpsp3.qcow2
#${QEMUBIN} -smp 2 -enable-kvm -m 1024 -monitor telnet::5437,server,nowait -vnc :7 -nographic -usb -usbdevice tablet -net nic,model=virtio,macaddr=52:54:00:ce:61:04 -net user,hostfwd=tcp::10022-:22 -hda xpsp3.qcow2

#debian user/virtio/hostfwd
#${QEMUBIN} -smp 2 -enable-kvm -m 1024 -monitor stdio -usb -usbdevice tablet -net nic,model=virtio,macaddr=52:54:00:ce:61:04 -net user,hostfwd=tcp::10022-:22 -hda debian.qcow2
#${QEMUBIN} -smp 2 -enable-kvm -m 1024 -monitor telnet::5437,server,nowait -vnc :7 -nographic -usb -usbdevice tablet -net nic,model=virtio,macaddr=52:54:00:ce:61:04 -net user,hostfwd=tcp::10022-:22 -hda debian.qcow2

#xp user/virtio/guestfwd
#${QEMUBIN} -smp 2 -enable-kvm -m 1024 -monitor stdio -usb -usbdevice tablet -net nic,model=virtio,macaddr=52:54:00:ce:61:04 -net user,guestfwd=tcp:10.0.2.100:80-tcp:192.168.168.90:33333 -hda xpsp3.qcow2
#${QEMUBIN} -smp 2 -enable-kvm -m 1024 -monitor telnet::5437,server,nowait -vnc :7 -nographic -usb -usbdevice tablet -net nic,model=virtio,macaddr=52:54:00:ce:61:04 -net user,guestfwd=tcp:10.0.2.100:80-tcp:192.168.168.90:33333 -hda xpsp3.qcow2

#debian user/virtio/guestfwd
#${QEMUBIN} -smp 2 -enable-kvm -m 1024 -monitor stdio -usb -usbdevice tablet -net nic,model=virtio,macaddr=52:54:00:ce:61:04 -net user,guestfwd=tcp:10.0.2.100:80-tcp:192.168.168.90:33333 -hda debian.qcow2
#${QEMUBIN} -smp 2 -enable-kvm -m 1024 -monitor telnet::5437,server,nowait -vnc :7 -nographic -usb -usbdevice tablet -net nic,model=virtio,macaddr=52:54:00:ce:61:04 -net user,guestfwd=tcp:10.0.2.100:80-tcp:192.168.168.90:33333 -hda debian.qcow2

#xp user/virtio/guestfwd(cmd)
#${QEMUBIN} -smp 2 -enable-kvm -m 1024 -monitor stdio -usb -usbdevice tablet -net nic,model=virtio,macaddr=52:54:00:ce:61:04 -net 'user,guestfwd=tcp:10.0.2.100:80-cmd:netcat 192.168.168.90 33333' -hda xpsp3.qcow2
#${QEMUBIN} -smp 2 -enable-kvm -m 1024 -monitor telnet::5437,server,nowait -vnc :7 -nographic -usb -usbdevice tablet -net nic,model=virtio,macaddr=52:54:00:ce:61:04 -net 'user,guestfwd=tcp:10.0.2.100:80-cmd:netcat 192.168.168.90 33333' -hda xpsp3.qcow2

#debian user/virtio/guestfwd(cmd)
#${QEMUBIN} -smp 2 -enable-kvm -m 1024 -monitor stdio -usb -usbdevice tablet -net nic,model=virtio,macaddr=52:54:00:ce:61:04 -net 'user,guestfwd=tcp:10.0.2.100:80-cmd:netcat 192.168.168.90 33333' -hda debian.qcow2
#${QEMUBIN} -smp 2 -enable-kvm -m 1024 -monitor telnet::5437,server,nowait -vnc :7 -nographic -usb -usbdevice tablet -net nic,model=virtio,macaddr=52:54:00:ce:61:04 -net 'user,guestfwd=tcp:10.0.2.100:80-cmd:netcat 192.168.168.90 33333' -hda debian.qcow2

# xp user/virtio-net-pci
#${QEMUBIN} -enable-kvm -m 1024 -monitor stdio -usb -usbdevice tablet -netdev user,id=usernet -device virtio-net-pci,netdev=usernet,mac=52:54:00:ce:61:04 -hda xpsp3.qcow2
#${QEMUBIN} -enable-kvm -m 1024 -monitor telnet::5437,server,nowait -vnc :7 -nographic -usb -usbdevice tablet -netdev user,id=usernet -device virtio-net-pci,netdev=usernet,mac=52:54:00:ce:61:04 -hda xpsp3.qcow2

# debian user/virtio-net-pci
#${QEMUBIN} -enable-kvm -m 1024 -monitor stdio -usb -usbdevice tablet -netdev user,id=usernet -device virtio-net-pci,netdev=usernet,mac=52:54:00:ce:61:04 -hda debian.qcow2
#${QEMUBIN} -enable-kvm -m 1024 -monitor telnet::5437,server,nowait -vnc :7 -nographic -usb -usbdevice tablet -netdev user,id=usernet -device virtio-net-pci,netdev=usernet,mac=52:54:00:ce:61:04 -hda debian.qcow2

# xp user/virtio-net-pci/hostfwd
#${QEMUBIN} -smp 2 -enable-kvm -m 1024 -monitor stdio -nographic -usb -usbdevice tablet -netdev user,id=usernet,hostfwd=tcp:192.168.168.90:33333-10.0.2.15:80 -device virtio-net-pci,netdev=usernet,mac=52:54:00:ce:61:04 -hda xpsp3.qcow2
#${QEMUBIN} -smp 2 -enable-kvm -m 1024 -monitor telnet::5437,server,nowait -vnc :7 -nographic -usb -usbdevice tablet -netdev user,id=usernet,restrict=on,hostfwd=tcp:192.168.168.90:33333-10.0.2.15:80 -device virtio-net-pci,netdev=usernet,mac=52:54:00:ce:61:04 -hda xpsp3.qcow2

# debian user/virtio-net-pci/hostfwd
#${QEMUBIN} -smp 2 -enable-kvm -m 1024 -monitor stdio -nographic -usb -usbdevice tablet -netdev user,id=usernet,hostfwd=tcp:192.168.168.90:33333-10.0.2.15:80 -device virtio-net-pci,netdev=usernet,mac=52:54:00:ce:61:04 -hda debian.qcow2
#${QEMUBIN} -smp 2 -enable-kvm -m 1024 -monitor telnet::5437,server,nowait -vnc :7 -nographic -usb -usbdevice tablet -netdev user,id=usernet,restrict=on,hostfwd=tcp:192.168.168.90:33333-10.0.2.15:80 -device virtio-net-pci,netdev=usernet,mac=52:54:00:ce:61:04 -hda debian.qcow2

# xp user/virtio-net-pci/guestfwd
#${QEMUBIN} -smp 2 -enable-kvm -m 1024 -monitor stdio -nographic -usb -usbdevice tablet -netdev user,id=usernet,guestfwd=tcp:10.0.2.100:80-tcp:192.168.168.90:33333 -device virtio-net-pci,netdev=usernet,mac=52:54:00:ce:61:04 -hda xpsp3.qcow2
#${QEMUBIN} -smp 2 -enable-kvm -m 1024 -monitor telnet::5437,server,nowait -vnc :7 -nographic -usb -usbdevice tablet -netdev user,id=usernet,restrict=on,guestfwd=tcp:10.0.2.100:80-tcp:192.168.168.90:33333 -device virtio-net-pci,netdev=usernet,mac=52:54:00:ce:61:04 -hda xpsp3.qcow2

# debian user/virtio-net-pci/guestfwd
#${QEMUBIN} -smp 2 -enable-kvm -m 1024 -monitor stdio -nographic -usb -usbdevice tablet -netdev user,id=usernet,guestfwd=tcp:10.0.2.100:80-tcp:192.168.168.90:33333 -device virtio-net-pci,netdev=usernet,mac=52:54:00:ce:61:04 -hda debian.qcow2
#${QEMUBIN} -smp 2 -enable-kvm -m 1024 -monitor telnet::5437,server,nowait -vnc :7 -nographic -usb -usbdevice tablet -netdev user,id=usernet,restrict=on,guestfwd=tcp:10.0.2.100:80-tcp:192.168.168.90:33333 -device virtio-net-pci,netdev=usernet,mac=52:54:00:ce:61:04 -hda debian.qcow2

# xp user/virtio-net-pci/guestfwd(cmd)
#${QEMUBIN} -enable-kvm -m 1024 -monitor stdio -nographic -usb -usbdevice tablet -netdev 'user,id=usernet,guestfwd=tcp:10.0.2.100:80-cmd:netcat 192.168.168.90 33333' -device virtio-net-pci,netdev=usernet,mac=52:54:00:ce:61:04 -hda xpsp3.qcow2
#${QEMUBIN} -enable-kvm -m 1024 -monitor telnet::5437,server,nowait -vnc :7 -nographic -usb -usbdevice tablet -netdev 'user,id=usernet,restrict=on,guestfwd=tcp:10.0.2.100:80-cmd:netcat 192.168.168.90 33333' -device virtio-net-pci,netdev=usernet,mac=52:54:00:ce:61:04 -hda xpsp3.qcow2

# debian user/virtio-net-pci/guestfwd(cmd)
#${QEMUBIN} -smp 2 -enable-kvm -m 1024 -monitor stdio -nographic -usb -usbdevice tablet -netdev 'user,id=usernet,guestfwd=tcp:10.0.2.100:80-cmd:netcat 192.168.168.90 33333' -device virtio-net-pci,netdev=usernet,mac=52:54:00:ce:61:04 -hda debian.qcow2
#${QEMUBIN} -smp 2 -enable-kvm -m 1024 -monitor telnet::5437,server,nowait -vnc :7 -nographic -usb -usbdevice tablet -netdev 'user,id=usernet,restrict=on,guestfwd=tcp:10.0.2.100:80-cmd:netcat 192.168.168.90 33333' -device virtio-net-pci,netdev=usernet,mac=52:54:00:ce:61:04 -hda debian.qcow2

# xp tap/virtio
#${QEMUBIN} -enable-kvm -m 1024 -monitor stdio -usb -usbdevice tablet -net nic,model=virtio,macaddr=52:54:00:ce:61:04 -net tap,ifname=tap1,script=no,downscript=no -hda xpsp3.qcow2
#${QEMUBIN} -enable-kvm -m 1024 -monitor telnet::5437,server,nowait -vnc :7 -nographic -usb -usbdevice tablet -net nic,model=virtio,macaddr=52:54:00:ce:61:04 -net tap,ifname=tap1,script=no,downscript=no -hda xpsp3.qcow2

# debian tap/virtio
#${QEMUBIN} -enable-kvm -m 1024 -monitor stdio -usb -usbdevice tablet -net nic,model=virtio,macaddr=52:54:00:ce:61:04 -net tap,ifname=tap1,script=no,downscript=no -hda debian.qcow2
#${QEMUBIN} -enable-kvm -m 1024 -monitor telnet::5437,server,nowait -vnc :7 -nographic -usb -usbdevice tablet -net nic,model=virtio,macaddr=52:54:00:ce:61:04 -net tap,ifname=tap1,script=no,downscript=no -hda debian.qcow2

# xp tap/virtio,vmware/vga
#${QEMUBIN} -enable-kvm -m 1024 -vga vmware -monitor stdio -usb -usbdevice tablet -net nic,model=virtio,macaddr=52:54:00:ce:61:04 -net tap,ifname=tap1,script=no,downscript=no -hda xpsp3.qcow2
#${QEMUBIN} -enable-kvm -m 1024 -vga vmware -monitor telnet::5437,server,nowait -vnc :7 -nographic -usb -usbdevice tablet -net nic,model=virtio,macaddr=52:54:00:ce:61:04 -net tap,ifname=tap1,script=no,downscript=no -hda xpsp3.qcow2

# debian tap/virtio,vmware/vga
#${QEMUBIN} -enable-kvm -m 1024 -vga vmware -monitor stdio -usb -usbdevice tablet -net nic,model=virtio,macaddr=52:54:00:ce:61:04 -net tap,ifname=tap1,script=no,downscript=no -hda debian.qcow2
#${QEMUBIN} -enable-kvm -m 1024 -vga vmware -monitor telnet::5437,server,nowait -vnc :7 -nographic -usb -usbdevice tablet -net nic,model=virtio,macaddr=52:54:00:ce:61:04 -net tap,ifname=tap1,script=no,downscript=no -hda debian.qcow2

# xp tap/virtio,block/virtio
#${QEMUBIN} -enable-kvm -m 1024 -monitor stdio -usb -usbdevice tablet -net nic,model=virtio,macaddr=52:54:00:ce:61:04 -net tap,ifname=tap1,script=no,downscript=no -drive file=xpsp3.qcow2,if=virtio
#${QEMUBIN} -enable-kvm -m 1024 -monitor telnet::5437,server,nowait -vnc :7 -nographic -usb -usbdevice tablet -net nic,model=virtio,macaddr=52:54:00:ce:61:04 -net tap,ifname=tap1,script=no,downscript=no -drive file=xpsp3.qcow2,if=virtio

# debian tap/virtio,block/virtio
#${QEMUBIN} -enable-kvm -m 1024 -monitor stdio -usb -usbdevice tablet -net nic,model=virtio,macaddr=52:54:00:ce:61:04 -net tap,ifname=tap1,script=no,downscript=no -drive file=debian.qcow2,if=virtio
#${QEMUBIN} -enable-kvm -m 1024 -monitor telnet::5437,server,nowait -vnc :7 -nographic -usb -usbdevice tablet -net nic,model=virtio,macaddr=52:54:00:ce:61:04 -net tap,ifname=tap1,script=no,downscript=no -drive file=debian.qcow2,if=virtio

# xp tap/virtio,vga/vmware,block/virtio
#${QEMUBIN} -enable-kvm -m 1024 -vga vmware -monitor stdio -usb -usbdevice tablet -net nic,model=virtio,macaddr=52:54:00:ce:61:04 -net tap,ifname=tap1,script=no,downscript=no -drive file=xpsp3.qcow2,if=virtio
#${QEMUBIN} -enable-kvm -m 1024 -vga vmware -monitor telnet::5437,server,nowait -vnc :7 -nographic -usb -usbdevice tablet -net nic,model=virtio,macaddr=52:54:00:ce:61:04 -net tap,ifname=tap1,script=no,downscript=no -drive file=xpsp3.qcow2,if=virtio

# debian tap/virtio,vga/vmware,block/virtio
#${QEMUBIN} -enable-kvm -m 1024 -vga vmware -monitor stdio -usb -usbdevice tablet -net nic,model=virtio,macaddr=52:54:00:ce:61:04 -net tap,ifname=tap1,script=no,downscript=no -drive file=debian.qcow2,if=virtio
#${QEMUBIN} -enable-kvm -m 1024 -vga vmware -monitor telnet::5437,server,nowait -vnc :7 -nographic -usb -usbdevice tablet -net nic,model=virtio,macaddr=52:54:00:ce:61:04 -net tap,ifname=tap1,script=no,downscript=no -drive file=debian.qcow2,if=virtio

# xp tap/vmxnet3,vga/vmware,block/virtio
#${QEMUBIN} -enable-kvm -m 1024 -vga vmware -monitor stdio -usb -usbdevice tablet -netdev tap,id=tapnet,ifname=tap1,script=no,downscript=no -device vmxnet3,netdev=tapnet,mac=52:54:00:ce:61:04 -drive file=xpsp3.qcow2,if=virtio
#${QEMUBIN} -enable-kvm -m 1024 -vga vmware -monitor telnet::5437,server,nowait -vnc :7 -nographic -usb -usbdevice tablet -netdev tap,id=tapnet,ifname=tap1,script=no,downscript=no -device vmxnet3,netdev=tapnet,mac=52:54:00:ce:61:04 -drive file=xpsp3.qcow2,if=virtio

# debian tap/vmxnet3,vga/vmware,block/virtio
#${QEMUBIN} -enable-kvm -m 1024 -vga vmware -monitor stdio -usb -usbdevice tablet -netdev tap,id=tapnet,ifname=tap1,script=no,downscript=no -device vmxnet3,netdev=tapnet,mac=52:54:00:ce:61:04 -drive file=debian.qcow2,if=virtio
#${QEMUBIN} -enable-kvm -m 1024 -vga vmware -monitor telnet::5437,server,nowait -vnc :7 -nographic -usb -usbdevice tablet -netdev tap,id=tapnet,ifname=tap1,script=no,downscript=no -device vmxnet3,netdev=tapnet,mac=52:54:00:ce:61:04 -drive file=debian.qcow2,if=virtio

# xp tap/virtio-net-pci
#${QEMUBIN} -smp 2 -enable-kvm -m 1024 -monitor stdio -usb -usbdevice tablet -netdev tap,id=tapnet,ifname=tap1,script=no,downscript=no -device virtio-net-pci,netdev=tapnet,mac=52:54:00:ce:61:04 -hda xpsp3.qcow2
#${QEMUBIN} -smp 2 -enable-kvm -m 1024 -monitor telnet::5437,server,nowait -vnc :7 -nographic -usb -usbdevice tablet -netdev tap,id=tapnet,ifname=tap1,script=no,downscript=no -device virtio-net-pci,netdev=tapnet,mac=52:54:00:ce:61:04 -hda xpsp3.qcow2

# debian tap/virtio-net-pci
#${QEMUBIN} -smp 2 -enable-kvm -m 1024 -monitor stdio -usb -usbdevice tablet -netdev tap,id=tapnet,ifname=tap1,script=no,downscript=no -device virtio-net-pci,netdev=tapnet,mac=52:54:00:ce:61:04 -hda debian.qcow2
#${QEMUBIN} -smp 2 -enable-kvm -m 1024 -monitor telnet::5437,server,nowait -vnc :7 -nographic -usb -usbdevice tablet -netdev tap,id=tapnet,ifname=tap1,script=no,downscript=no -device virtio-net-pci,netdev=tapnet,mac=52:54:00:ce:61:04 -hda debian.qcow2

# xp tap/virtio-net-pci,block/virtio
#${QEMUBIN} -smp 2 -enable-kvm -m 1024 -monitor stdio -usb -usbdevice tablet -netdev tap,id=tapnet,ifname=tap1,script=no,downscript=no -device virtio-net-pci,netdev=tapnet,mac=52:54:00:ce:61:04 -drive file=xpsp3.qcow2,if=virtio
#${QEMUBIN} -smp 2 -enable-kvm -m 1024 -monitor telnet::5437,server,nowait -vnc :7 -nographic -usb -usbdevice tablet -netdev tap,id=tapnet,ifname=tap1,script=no,downscript=no -device virtio-net-pci,netdev=tapnet,mac=52:54:00:ce:61:04 -drive file=xpsp3.qcow2,if=virtio

# debian tap/virtio-net-pci,block/virtio
#${QEMUBIN} -smp 2 -enable-kvm -m 1024 -monitor stdio -usb -usbdevice tablet -netdev tap,id=tapnet,ifname=tap1,script=no,downscript=no -device virtio-net-pci,netdev=tapnet,mac=52:54:00:ce:61:04 -drive file=debian.qcow2,if=virtio
#${QEMUBIN} -smp 2 -enable-kvm -m 1024 -monitor telnet::5437,server,nowait -vnc :7 -nographic -usb -usbdevice tablet -netdev tap,id=tapnet,ifname=tap1,script=no,downscript=no -device virtio-net-pci,netdev=tapnet,mac=52:54:00:ce:61:04 -drive file=debian.qcow2,if=virtio

# xp vmware/vga,tap/virtio-net-pci,block/virtio
#${QEMUBIN} -smp 2 -enable-kvm -m 1024 -vga vmware -monitor stdio -usb -usbdevice tablet -netdev tap,id=tapnet,ifname=tap1,script=no,downscript=no -device virtio-net-pci,netdev=tapnet,mac=52:54:00:ce:61:04 -drive file=xpsp3.qcow2,if=virtio
#${QEMUBIN} -smp 2 -enable-kvm -m 1024 -vga vmware -monitor telnet::5437,server,nowait -vnc :7 -nographic -usb -usbdevice tablet -netdev tap,id=tapnet,ifname=tap1,script=no,downscript=no -device virtio-net-pci,netdev=tapnet,mac=52:54:00:ce:61:04 -drive file=xpsp3.qcow2,if=virtio

# debian vmware/vga,tap/virtio-net-pci,block/virtio
#${QEMUBIN} -smp 2 -enable-kvm -m 1024 -vga vmware -monitor stdio -usb -usbdevice tablet -netdev tap,id=tapnet,ifname=tap1,script=no,downscript=no -device virtio-net-pci,netdev=tapnet,mac=52:54:00:ce:61:04 -drive file=debian.qcow2,if=virtio
#${QEMUBIN} -smp 2 -enable-kvm -m 1024 -vga vmware -monitor telnet::5437,server,nowait -vnc :7 -nographic -usb -usbdevice tablet -netdev tap,id=tapnet,ifname=tap1,script=no,downscript=no -device virtio-net-pci,netdev=tapnet,mac=52:54:00:ce:61:04 -drive file=debian.qcow2,if=virtio

# xp tap/virtio-net-pci/multiqueue
#${QEMUBIN} -smp 2 -enable-kvm -m 1024 -monitor stdio -usb -usbdevice tablet -netdev tap,id=tapnet,ifname=tap0,script=no,downscript=no,queues=4 -device virtio-net-pci,netdev=tapnet,mac=52:54:00:ce:61:04,mq=on,vectors=10 -hda xpsp3.qcow2
#${QEMUBIN} -smp 2 -enable-kvm -m 1024 -monitor telnet::5437,server,nowait -vnc :7 -nographic -usb -usbdevice tablet -netdev tap,id=tapnet,ifname=tap0,script=no,downscript=no,queues=4 -device virtio-net-pci,netdev=tapnet,mac=52:54:00:ce:61:04,mq=on,vectors=10 -hda xpsp3.qcow2

# debian tap/virtio-net-pci/multiqueue
#${QEMUBIN} -smp 2 -enable-kvm -m 1024 -monitor stdio -usb -usbdevice tablet -netdev tap,id=tapnet,ifname=tap0,script=no,downscript=no,queues=4 -device virtio-net-pci,netdev=tapnet,mac=52:54:00:ce:61:04,mq=on,vectors=10 -hda debian.qcow2
#${QEMUBIN} -smp 2 -enable-kvm -m 1024 -monitor telnet::5437,server,nowait -vnc :7 -nographic -usb -usbdevice tablet -netdev tap,id=tapnet,ifname=tap0,script=no,downscript=no,queues=4 -device virtio-net-pci,netdev=tapnet,mac=52:54:00:ce:61:04,mq=on,vectors=10 -hda debian.qcow2

# xp tap/virtio-net-pci/multiqueue,block/virtio
#${QEMUBIN} -smp 2 -enable-kvm -m 1024 -monitor stdio -usb -usbdevice tablet -netdev tap,id=tapnet,ifname=tap0,script=no,downscript=no,queues=4 -device virtio-net-pci,netdev=tapnet,mac=52:54:00:ce:61:04,mq=on,vectors=10 -drive file=xpsp3.qcow2,if=virtio
#${QEMUBIN} -smp 2 -enable-kvm -m 1024 -monitor telnet::5437,server,nowait -vnc :7 -nographic -usb -usbdevice tablet -netdev tap,id=tapnet,ifname=tap0,script=no,downscript=no,queues=4 -device virtio-net-pci,netdev=tapnet,mac=52:54:00:ce:61:04,mq=on,vectors=10 -drive file=xpsp3.qcow2,if=virtio

# debian tap/virtio-net-pci/multiqueue,block/virtio
#${QEMUBIN} -smp 2 -enable-kvm -m 1024 -monitor stdio -usb -usbdevice tablet -netdev tap,id=tapnet,ifname=tap0,script=no,downscript=no,queues=4 -device virtio-net-pci,netdev=tapnet,mac=52:54:00:ce:61:04,mq=on,vectors=10 -drive file=debian.qcow2,if=virtio
#${QEMUBIN} -smp 2 -enable-kvm -m 1024 -monitor telnet::5437,server,nowait -vnc :7 -nographic -usb -usbdevice tablet -netdev tap,id=tapnet,ifname=tap0,script=no,downscript=no,queues=4 -device virtio-net-pci,netdev=tapnet,mac=52:54:00:ce:61:04,mq=on,vectors=10 -drive file=debian.qcow2,if=virtio

# xp vmware/vga,tap/virtio-net-pci/multiqueue,block/virtio
#${QEMUBIN} -smp 2 -enable-kvm -m 1024 -vga vmware -monitor stdio -usb -usbdevice tablet -netdev tap,id=tapnet,ifname=tap0,script=no,downscript=no,queues=4 -device virtio-net-pci,netdev=tapnet,mac=52:54:00:ce:61:04,mq=on,vectors=10 -drive file=xpsp3.qcow2,if=virtio
#${QEMUBIN} -smp 2 -enable-kvm -m 1024 -vga vmware -monitor telnet::5437,server,nowait -vnc :7 -nographic -usb -usbdevice tablet -netdev tap,id=tapnet,ifname=tap0,script=no,downscript=no,queues=4 -device virtio-net-pci,netdev=tapnet,mac=52:54:00:ce:61:04,mq=on,vectors=10 -drive file=xpsp3.qcow2,if=virtio

# debian vmware/vga,tap/virtio-net-pci/multiqueue,block/virtio
#${QEMUBIN} -smp 2 -enable-kvm -m 1024 -vga vmware -monitor stdio -usb -usbdevice tablet -netdev tap,id=tapnet,ifname=tap0,script=no,downscript=no,queues=4 -device virtio-net-pci,netdev=tapnet,mac=52:54:00:ce:61:04,mq=on,vectors=10 -drive file=debian.qcow2,if=virtio
#${QEMUBIN} -smp 2 -enable-kvm -m 1024 -vga vmware -monitor telnet::5437,server,nowait -vnc :7 -nographic -usb -usbdevice tablet -netdev tap,id=tapnet,ifname=tap0,script=no,downscript=no,queues=4 -device virtio-net-pci,netdev=tapnet,mac=52:54:00:ce:61:04,mq=on,vectors=10 -drive file=debian.qcow2,if=virtio

# libvirt
#qemu-system-x86_64 -name xpsp3 -machine pc-i440fx-trusty,accel=tcg,usb=off -cpu kvm32 -enable-kvm -m 1024 -realtime mlock=off -smp 1,sockets=1,cores=1,threads=1 -uuid 13d175a1-cd7d-33e1-8a77-f326fdd6f189 -no-user-config -nodefaults -chardev socket,id=charmonitor,path=/work/images/xpsp3.monitor,server,nowait -mon chardev=charmonitor,id=monitor,mode=control -rtc base=localtime -boot strict=on -device piix3-usb-uhci,id=usb,bus=pci.0,addr=0x1.0x2 -drive file=/work/images/xpsp3.qcow2,if=none,id=drive-ide0-0-0,format=qcow2,cache=off -device ide-hd,bus=ide.0,unit=0,drive=drive-ide0-0-0,id=ide0-0-0,bootindex=1 -drive if=none,id=drive-ide0-1-0,readonly=on,format=raw -device ide-cd,bus=ide.1,unit=0,drive=drive-ide0-1-0,id=ide0-1-0 -netdev tap,fd=24,id=hostnet0 -device virtio-net-pci,netdev=hostnet0,id=net0,mac=52:54:00:ce:61:04,bus=pci.0,addr=0x3 -chardev pty,id=charserial0 -device isa-serial,chardev=charserial0,id=serial0 -device usb-tablet,id=input0 -vnc 127.0.0.1:0 -device vmware-svga,id=video0,bus=pci.0,addr=0x2 -device intel-hda,id=sound0,bus=pci.0,addr=0x4 -device hda-duplex,id=sound0-codec0,bus=sound0.0,cad=0 -device virtio-balloon-pci,id=balloon0,bus=pci.0,addr=0x5
#qemu-system-x86_64 -name xpsp3 -machine pc-i440fx-trusty,accel=tcg,usb=off -cpu kvm32 -enable-kvm -m 1024 -realtime mlock=off -smp 1,sockets=1,cores=1,threads=1 -uuid 13d175a1-cd7d-33e1-8a77-f326fdd6f189 -no-user-config -nodefaults -chardev socket,id=charmonitor,path=/work/images/xpsp3.monitor,server,nowait -mon chardev=charmonitor,id=monitor,mode=control -rtc base=localtime -boot strict=on -device piix3-usb-uhci,id=usb,bus=pci.0,addr=0x1.0x2 -drive file=/work/images/xpsp3.qcow2,if=none,id=drive-ide0-0-0,format=qcow2,cache=off -device ide-hd,bus=ide.0,unit=0,drive=drive-ide0-0-0,id=ide0-0-0,bootindex=1 -drive if=none,id=drive-ide0-1-0,readonly=on,format=raw -device ide-cd,bus=ide.1,unit=0,drive=drive-ide0-1-0,id=ide0-1-0 -netdev tap,ifname=tap1,id=hostnet0 -device virtio-net-pci,netdev=hostnet0,id=net0,mac=52:54:00:ce:61:04,bus=pci.0,addr=0x3 -chardev pty,id=charserial0 -device isa-serial,chardev=charserial0,id=serial0 -device usb-tablet,id=input0 -vnc 127.0.0.1:0 -device vmware-svga,id=video0,bus=pci.0,addr=0x2 -device intel-hda,id=sound0,bus=pci.0,addr=0x4 -device hda-duplex,id=sound0-codec0,bus=sound0.0,cad=0 -device virtio-balloon-pci,id=balloon0,bus=pci.0,addr=0x5

if [ "W$1" == "W0" ]
then
	${QEMUBIN} -enable-kvm -m 1024 -monitor stdio -net nic,model=pcnet,macaddr=52:54:00:ce:61:04 -net user -hda debian.qcow2 #-gdb tcp::1234 #-S
fi

if [ "W$1" == "W1" ]
then
	${QEMUBIN} -enable-kvm -m 1024 -monitor stdio -net nic,model=pcnet,macaddr=52:54:00:ce:61:06 -net user -hda debian1.qcow2 #-gdb tcp::1236 #-S
fi

if [ "W$1" == "W2" ]
then
	${QEMUBIN} -enable-kvm -m 1024 -monitor stdio -net nic,model=pcnet,macaddr=52:54:00:ce:61:08 -net user -hda debian2.qcow2 #-gdb tcp::1238 #-S
fi

if [ "W$1" == "W10" ]
then
	kvm -enable-kvm -hda debian.raw -m 256 -nographic -vnc :10 -monitor telnet::5430,server,nowait -usb -usbdevice tablet -net nic,model=pcnet,macaddr=00:11:22:33:44:44 -net tap,ifname=tap10,script=no,downscript=no
fi

if [ "W$1" == "W11" ]
then
	kvm -enable-kvm -hda debian1.qcow2 -m 256 -nographic -vnc :11 -monitor telnet::5431,server,nowait -usb -usbdevice tablet -net nic,model=pcnet,macaddr=00:11:22:33:44:55 -net tap,ifname=tap11,script=no,downscript=no
fi

if [ "W$1" == "W12" ]
then
	kvm -enable-kvm -hda debian2.qcow2 -m 256 -nographic -vnc :12 -monitor telnet::5432,server,nowait -usb -usbdevice tablet -net nic,model=pcnet,macaddr=00:11:22:33:44:66 -net tap,ifname=tap12,script=no,downscript=no
fi

