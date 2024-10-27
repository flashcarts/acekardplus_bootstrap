# Acekard+ bootstrap

This is a drop-in replacement for the Acekard+ system menu that will boot directly to `/boot.nds` on the SD card.

## Usage

1. Copy `akmenu2_fat.nds` to the root of your SD card
1. Copy your homebrew of choice to the root of your SD card and rename to `boot.nds`
1. Boot and enjoy

## Explanation

The Acekard+ bootloader will only load the ARM9 binary of `akmenu2_fat.nds`. This means that the ARM9 in that file is responsible for loading the remaining ARM7 binary.

This works by using Acekard's custom IPC implementation. It is a full-duplex IPC system; IPC_ARM9 at 0x02FFF200 is for the ARM9's message to ARM7, while IPC_ARM7 at 0x02FFF20C is the other way around.

When the ARM7 receives `1` from the ARM9, it performs a BIOS-provided soft reset. That soft reset, among other things, will execute the address in the ROM header, which is located at 0x02FFFE00.

Thus, what this abomination does, is embed nds-miniboot's ARM7 and ARM9 binaries directly (so that the bootloader will load both at once), repoint the header's ARM7 addresses to the embedded nds-miniboot ARM7, instruct the existing ARM7 to reset, then jump straight to the embedded nds-miniboot ARM9.

## Credits

- [BlocksDS](https://github.com/blocksds) for the toolchain used in this project
- [asiekierka](https://github.com/asiekierka) for [nds-miniboot](https://github.com/asiekierka/nds-miniboot), as well as linkerscripts from that repository that was shamelessly stolen

## License

This application is provided under the terms of the Zlib license. See `LICENSE.txt` for details.

Additionally nds-miniboot, provided with the application, is subject to a number of licenses; see `nds-miniboot/LICENSE` for details.
