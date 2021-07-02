#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="lr-blastem"
rp_module_desc="Sega 16 bit emu - blastem port for libretro"
rp_module_help="ROM Extensions: .bin .cue .gen .gg .iso .md .sg .smd .sms .zip\nCopy your Game Gear roms to $romdir/gamegear\nMasterSystem roms to $romdir/mastersystem\nMegadrive / Genesis roms to $romdir/megadrive\nSG-1000 roms to $romdir/sg-1000\nSegaCD roms to $romdir/segacd\nThe Sega CD requires the BIOS files bios_CD_U.bin and bios_CD_E.bin and bios_CD_J.bin copied to $biosdir"
rp_module_licence="https://github.com/libretro/blastem/blob/libretro/COPYING"
rp_module_repo="git https://github.com/libretro/blastem.git libretro"
rp_module_section="exp"

function sources_lr-blastem() {
    gitPullOrClone
}

function build_lr-blastem() {
    make -f Makefile.libretro clean
    make -f Makefile.libretro
    md_ret_require="$md_build/blastem_libretro.so"
}

function install_lr-blastem() {
    md_ret_files=(
        'blastem_libretro.so'
        
    )
}

function configure_lr-blastem() {
    local system
    local def
    for system in  genesis genesish megadrive megadrive-japan; do
        def=0
        
        mkRomDir "$system"
        ensureSystemretroconfig "$system"
        addEmulator "$def" "$md_id" "$system" "$md_inst/blastem_libretro.so"
        addSystem "$system"
		
    done
}
