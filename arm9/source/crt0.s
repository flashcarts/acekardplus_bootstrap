// Copyright (c) 2024 lifehackerhansol
//
// SPDX-License-Identifier: Zlib

    .arm
    .syntax unified
    .global _start
    .section .start, "ax"

_start:
    // Fix NDS header values
    ldr r1, =0x02FFFE00
    // set header arm9 address and binary size
    adr r0, _arm9_bin
    str r0, [r1, #0x24]
    str r0, [r1, #0x28]
    mov r0, #(_arm9_bin_end - _arm9_bin)
    str r0, [r1, #0x2C]

    // set header arm7 address and binary size
    adr r0, _arm7_bin
    str r0, [r1, #0x34]
    str r0, [r1, #0x38]
    mov r0, #(_arm7_bin_end - _arm7_bin)
    str r0, [r1, #0x3C]

    // Instruct ARM7 to reboot
    // 0x02FFF200 == ARM9 IPC message to ARM7
    mov r0, #1
    ldr r1, =0x02FFF200
    str r0, [r1]

    b _arm9_bin

.pool

_arm7_bin:
    .incbin "arm9/data/arm7.bin"
_arm7_bin_end:

_arm9_bin:
    .incbin "arm9/data/arm9.bin"
_arm9_bin_end:
