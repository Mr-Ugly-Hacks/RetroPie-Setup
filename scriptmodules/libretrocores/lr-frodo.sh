#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="lr-frodo"
rp_module_desc="C64 emulator - port of frodo for libretro"
rp_module_help="ROM Extensions: .crt .d64 .g64 .prg .t64 .tap .x64 .zip .vsf\n\nCopy your Commodore 64 games to $romdir/c64"
rp_module_licence="GPL2 https://github.com/libretro/frodo-libretro/blob/master/COPYING"
rp_module_repo="git https://github.com/libretro/frodo-libretro.git"
rp_module_section="exp"
rp_module_flags=""

function sources_lr-frodo() {
    gitPullOrClone
}

function build_lr-frodo() {
    make -f Makefile clean
    make -f Makefile.libretro
    md_ret_require="$md_build/frodo_libretro.so"
}

function install_lr-frodo() {
    md_ret_files=(
        'frodo_libretro.so'
    )
}

function configure_lr-frodo() {
    mkRomDir "c64"
    ensureSystemretroconfig "c64"

    cp -R "$md_inst/data" "$biosdir"
    chown -R $user:$user "$biosdir/data"

    addEmulator 0 "$md_id" "c64" "$md_inst/frodo_libretro.so"
    addSystem "c64"
	
}