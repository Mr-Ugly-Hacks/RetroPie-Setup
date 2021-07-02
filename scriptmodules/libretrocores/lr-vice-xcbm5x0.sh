#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="lr-vice-xcbm5x0"
rp_module_desc="cbm5x0 emulator - port of VICE for libretro"
rp_module_help="ROM Extensions: .crt .d64 .g64 .prg .t64 .tap .x64sc .zip .vsf\n\nCopy your Commodore 64SC games to $romdir/c64sc"
rp_module_licence="GPL2 https://raw.githubusercontent.com/libretro/vice-libretro/master/vice/COPYING"
rp_module_repo="git https://github.com/libretro/vice-libretro.git"
rp_module_section="opt"
rp_module_flags=""

function sources_lr-vice-xcbm5x0() {
    gitPullOrClone
}

function build_lr-vice-xcbm5x0() {
    make -f Makefile clean
    make -f Makefile EMUTYPE=xcbm5x0
    md_ret_require="$md_build/vice_xcbm5x0_libretro.so"
}

function install_lr-vice-xcbm5x0() {
    md_ret_files=(
        'vice/data'
        'vice/COPYING'
        'vice_xcbm5x0_libretro.so'
    )
}

function configure_lr-vice-xcbm5x0() {
    mkRomDir "cbm5x0"
    ensureSystemretroconfig "cbm5x0"

    cp -R "$md_inst/data" "$biosdir"
    chown -R $user:$user "$biosdir/data"

    addEmulator 1 "$md_id" "cbm5x0" "$md_inst/vice_xcbm5x0_libretro.so"
    addSystem "cbm5x0"
	
}
