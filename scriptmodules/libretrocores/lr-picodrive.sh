#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="lr-picodrive"
rp_module_desc="Sega 8/16 bit emu - picodrive arm optimised libretro core"
rp_module_help="ROM Extensions: .32x .iso .cue .sms .smd .bin .gen .md .sg .zip\n\nCopy your Megadrive / Genesis roms to $romdir/megadrive\nMasterSystem roms to $romdir/mastersystem\nSega 32X roms to $romdir/sega32x and\nSegaCD roms to $romdir/segacd\nThe Sega CD requires the BIOS files us_scd1_9210.bin, eu_mcd1_9210.bin, jp_mcd1_9112.bin copied to $biosdir"
rp_module_licence="NONCOM https://raw.githubusercontent.com/libretro/picodrive/master/COPYING"
rp_module_repo="git https://github.com/libretro/picodrive.git master"
rp_module_section="main"

function sources_lr-picodrive() {
    gitPullOrClone
}

function build_lr-picodrive() {
    local params=()
    if isPlatform "arm"; then
        params+=(platform=armv ARM_ASM=1 use_fame=0 use_cyclone=1 use_sh2drc=1 use_svpdrc=1)
        if isPlatform "armv6"; then
            params+=(use_cz80=0 use_drz80=1)
        else
            params+=(use_cz80=1 use_drz80=0)
        fi
    elif isPlatform "aarch64"; then
        params+=(use_sh2drc=0)
    fi
    make clean
    make -f Makefile.libretro "${params[@]}"
    md_ret_require="$md_build/picodrive_libretro.so"
}

function install_lr-picodrive() {
    md_ret_files=(
        'AUTHORS'
        'COPYING'
        'picodrive_libretro.so'
        'README'
    )
}

function configure_lr-picodrive() {
    local system
			 
	for system in genesis genesish megadrive megadrive-japan megacd-japan mastersystem segacd sc-3000 markiii; do
	mkRomDir "$system"
	ensureSystemretroconfig "$system"
	addEmulator 0 "$md_id" "$system" "$md_inst/picodrive_libretro.so"
	addSystem "$system"
	done
	
	mkRomDir sega32x
    mkRomDir pico
    ensureSystemretroconfig "sega32x"
    ensureSystemretroconfig "pico"
    addEmulator 1 "$md_id" "sega32x" "$md_inst/picodrive_libretro.so"
    addEmulator 1 "$md_id" "pico" "$md_inst/picodrive_libretro.so"
    addSystem "sega32x"
    addSystem "pico"
}
