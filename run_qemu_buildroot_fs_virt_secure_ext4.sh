OPTEE=/home/jbech/devel/optee_projects/qemu

# Note that BIOS has to be rebuilt and should point to the kernel and initrd
# from buildroot and linux here.
# + BIOS_NSEC_BLOB=/home/jbech/devel/medicineyeh/linux/arch/arm/boot/zImage \
# + BIOS_NSEC_ROOTFS=/home/jbech/devel/medicineyeh/buildroot/output/images/rootfs.cpio \

BIOS=$OPTEE/out/bios-qemu/bios.bin
EXT4=./buildroot/output/images/rootfs.ext4
#EXT4=/home/jbech/devel/optee_projects/oe-optee/build/tmp-glibc/deploy/images/qemu-optee32/optee-image-qemu-optee32.ext4


export PATH=$OPTEE/qemu/arm-softmmu:$PATH

echo $OPTEE
echo $BIOS
echo $EXT4

qemu-system-arm \
	-s -S \
	-M virt,secure=on \
	-cpu cortex-a15 \
	-bios $BIOS \
	-serial tcp:localhost:54320 -serial tcp:localhost:54321 \
	-m 1057 \
	--nographic \
	-netdev user,id=unet,hostfwd=tcp::5001-:22,hostfwd=tcp::2159-:2159 \
	-device virtio-net-device,netdev=unet \
	-device virtio-scsi-device,id=scsi \
	-drive file=$EXT4,id=rootimg,if=none,format=raw \
	-device scsi-hd,drive=rootimg

#	-net nic,model=rtl8139 \
