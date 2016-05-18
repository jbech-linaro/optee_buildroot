qemu-system-arm \
	-M vexpress-a9 \
	-dtb ./linux/arch/arm/boot/dts/vexpress-v2p-ca9.dtb \
	-kernel ./linux/arch/arm/boot/zImage \
	-append "console=ttyAMA0" \
	-initrd ./buildroot/output/images/rootfs.cpio \
	--nographic \
	-netdev user,id=unet,hostfwd=tcp::5001-:22,hostfwd=tcp::2159-:2159 \
	-device virtio-net-device,netdev=unet
