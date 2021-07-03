#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="lr-gong"
rp_module_desc="Gong Pong port to libretro"
rp_module_licence="GPL3 https://raw.githubusercontent.com/libretro/gong/master/COPYING"
rp_module_repo="git https://github.com/libretro/gong.git"
rp_module_section="exp"
rp_module_flags=""

function sources_lr-gong() {
    gitPullOrClone 
}

function build_lr-gong() {
    make -f Makefile.libretro clean
    make -f Makefile.libretro 
    md_ret_require="$md_build/gong_libretro.so"
}

function install_lr-gong() {
    md_ret_files=(
        'gong_libretro.so'
    )
}

function configure_lr-gong() {
    setConfigRoot "ports"

    addPort "$md_id" "gong" "gong" "$md_inst/gong_libretro.so"

    ensureSystemretroconfig "ports/gong"
}