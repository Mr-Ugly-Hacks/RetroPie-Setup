#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="lr-hbmame"
rp_module_desc="HB MAME - Home Brew MAME port for libretro"
rp_module_help="ROM Extension: .zip\n\nCopy your MAME roms to either $romdir/hbmame-libretro or\n$romdir/arcade"
rp_module_licence="GPL2 https://raw.githubusercontent.com/libretro/hbmame-libretro/master/COPYING"
rp_module_repo="git https://github.com/libretro/hbmame-libretro.git master"
rp_module_section="exp"
rp_module_flags=""


function depends_lr-hbmame() {
    if compareVersions $__gcc_version lt 7; then
        md_ret_errors+=("Sorry, you need an OS with gcc 7 or newer to compile $md_id")
        return 1
    fi
    local depends=(libasound2-dev)
    isPlatform "gles" && depends+=(libgles2-mesa-dev)
    isPlatform "gl" && depends+=(libglu1-mesa-dev)
    getDepends "${depends[@]}"
}

function sources_lr-hbmame() {
    gitPullOrClone
}

function build_lr-hbmame() {
    rpSwap on 4096
    make -f Makefile.libretro
    rpSwap off
    md_ret_require="$md_build/hbmame_libretro.so"
}

function install_lr-hbmame() {
    md_ret_files=(
        'COPYING'
        'hbmame_libretro.so'
        'README.md'
    )
}

function configure_lr-hbmame() {
    local system
    for system in arcade hbmame-libretro; do
        mkRomDir "$system"
        ensureSystemretroconfig "$system"
        addEmulator 0 "$md_id" "$system" "$md_inst/hbmame_libretro.so"
        addSystem "$system"
    done
}
