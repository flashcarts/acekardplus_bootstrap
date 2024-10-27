// Copyright (c) 2024 lifehackerhansol
//
// SPDX-License-Identifier: Zlib

    .arm
    .syntax unified
    .global _start
    .section .start, "ax"

_start:
    // set header arm7 addresses
    adr r0, _arm7_bin
    ldr r1, =0x02FFFE34
    str r0, [r1]
    add r1, r1, 4
    str r0, [r1]

    // Instruct ARM7 to reboot
    // 0x02FFF200 == ARM9 IPC message to ARM7
    mov r0, #1
    ldr r1, =0x02FFF200
    str r0, [r1]

    b _arm9_bin

.pool

_arm7_bin:
    .incbin "arm9/data/arm7.bin"

_arm9_bin:
    .incbin "arm9/data/arm9.bin"
