#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="lr-mesen-s"
rp_module_desc="Super Nintendo emu - mesen-s  port for libretro"
rp_module_help="ROM Extensions: .bin .smc .sfc .fig .swc .mgd .zip\n\nCopy your SNES roms to $romdir/snes"
rp_module_licence="GPL3 https://raw.githubusercontent.com/libretro/Mesen-S/master/LICENSE"
rp_module_repo="git https://github.com/libretro/Mesen-S.git master"
rp_module_section="exp"

function sources_lr-mesen-s() {
    gitPullOrClone
}

function build_lr-mesen-s() {
    local params=()
    isPlatform "arm" && params+=(platform="armv")

    cd libretro
    make "${params[@]}" clean
    make "${params[@]}"
    md_ret_require="$md_build/libretro/mesen-s_libretro.so"
}

function install_lr-mesen-s() {
    md_ret_files=(
        'libretro/mesen-s_libretro.so'
        'docs'
    )
}

function configure_lr-mesen-s() {
    local system
    for system in snes snesh sfc sufami snesmsu1 satellaview gb gbc sgb; do
        mkRomDir "$system"
        ensureSystemretroconfig "$system"
														 
        addEmulator 0 "$md_id" "$system" "$md_inst/mesen-s_libretro.so"
        addSystem "$system"
		
    done
}
