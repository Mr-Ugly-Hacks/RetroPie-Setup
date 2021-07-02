#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="lr-beetle-gba"
rp_module_desc="GBA emulator - mednafen_gba port for libretro"
rp_module_help="ROM Extensions: .gba .zip\n\nCopy your Game Boy Advance roms to $romdir/gba\n\nCopy the required BIOS file gba_bios.bin to $biosdir"
rp_module_licence="GPL2 https://raw.githubusercontent.com/libretro/beetle-gba-libretro/master/COPYING"
rp_module_repo="git https://github.com/libretro/beetle-gba-libretro.git master"
rp_module_section="exp"
rp_module_flags="!armv6"

function sources_lr-beetle-gba() {
    gitPullOrClone
}

function build_lr-beetle-gba() {
    make
    md_ret_require="$md_build/mednafen_gba_libretro.so"
}

function install_lr-beetle-gba() {
    md_ret_files=(
        'mednafen_gba_libretro.so'
    )
}

function configure_lr-beetle-gba() {
    mkRomDir "gba"
    ensureSystemretroconfig "gba"

    addEmulator 0 "$md_id" "gba" "$md_inst/mednafen_gba_libretro.so"
    addSystem "gba"
	
	mkRomDir "gbah"
    ensureSystemretroconfig "gbah"

    addEmulator 0 "$md_id" "gbah" "$md_inst/mednafen_gba_libretro.so"
    addSystem "gbah"
	
	mkRomDir "gba-jp"
    ensureSystemretroconfig "gba-jp"

    addEmulator 0 "$md_id" "gba-jp" "$md_inst/mednafen_gba_libretro.so"
    addSystem "gba-jp"
}
