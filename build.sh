set -e

make -C nds-miniboot
mkdir -p arm9/data
cp nds-miniboot/build/arm7.bin nds-miniboot/build/arm9.bin arm9/data
make
