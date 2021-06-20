#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="lr-meteor"
rp_module_desc="GBA emu - Meteor port for libretro."
rp_module_help="ROM Extensions: .gba .zip .7z\n\nCopy your Game Boy Advance roms to $romdir/gba"
rp_module_licence="GPL3 https://raw.githubusercontent.com/libretro/meteor-libretro/master/COPYING"
rp_module_repo="git https://github.com/libretro/meteor-libretro.git"
rp_module_section="exp"
rp_module_flags=""

function sources_lr-meteor() {
    gitPullOrClone
}

function build_lr-meteor() {
    cd libretro
    make clean
    make 
    md_ret_require="$md_build/libretro/meteor_libretro.so"
}

function install_lr-meteor() {
    md_ret_files=(
	'libretro/meteor_libretro.so'
    )
}

function configure_lr-meteor() {
    mkRomDir "gba"
	mkRomDir "gbah"
	mkRomDir "gba-jp"
    ensureSystemretroconfig "gba"
	ensureSystemretroconfig "gbah"
	ensureSystemretroconfig "gba-jp"

    addEmulator 0 "$md_id" "gba" "$md_inst/meteor_libretro.so"
	addEmulator 0 "$md_id" "gbah" "$md_inst/meteor_libretro.so"
	addEmulator 0 "$md_id" "gba-jp" "$md_inst/meteor_libretro.so"
    addSystem "gba"
	addSystem "gbah"
	addSystem "gba-jp"
}