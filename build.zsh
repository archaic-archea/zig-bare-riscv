rm -rf drive

mkdir drive
mkdir drive/boot

zig build-exe src/main.zig src/entry.s -T conf/linker.ld -target riscv64-freestanding -mcpu=generic_rv64+m+a+c -mcmodel small
mv main drive/boot/zig-kern
cp conf/spark.cfg drive/boot/spark.cfg
rm main.o

qemu-system-riscv64 \
    -machine virt \
    -cpu rv64 \
    -smp 1 \
    -m 8G \
    -global virtio-mmio.force-legacy=false \
    -object rng-random,filename=/dev/urandom,id=rng0 \
    -device nvme,serial=deadbeff,drive=disk1 -drive id=disk1,format=raw,if=none,file=fat:rw:drive \
    -device virtio-rng-device,rng=rng0 \
    -device virtio-gpu-device \
    -bios conf/opensbi-riscv64-generic-fw_jump.bin \
    -kernel conf/spark-riscv-sbi-release.bin \
    -serial mon:stdio \
    -no-reboot