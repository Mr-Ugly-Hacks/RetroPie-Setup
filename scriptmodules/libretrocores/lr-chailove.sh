#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="lr-chailove"
rp_module_desc="2D Game Framework with ChaiScript roughly inspired by the LÖVE API to libretro"
rp_module_help="ROM Extension: .chai .chailove\n\nCopy your ChaiLove games to $romdir/ports/chailove"
rp_module_licence="MIT https://raw.githubusercontent.com/libretro/libretro-chailove/master/COPYING"
rp_module_repo="git https://github.com/libretro/libretro-chailove.git"
rp_module_section="exp"

function sources_lr-chailove() {
    gitPullOrClone
}

function build_lr-chailove() {
    make clean
    make -j2
    md_ret_require="$md_build/chailove_libretro.so"
}

function install_lr-chailove() {
    md_ret_files=(
        'chailove_libretro.so'
    )
}

function configure_lr-chailove() {
    
	mkRomDir "chailove"
    ensureSystemretroconfig "chailove"

    addEmulator 1 "$md_id" "chailove" "$md_inst/chailove_libretro.so"
    addSystem "chailove"
		
    }