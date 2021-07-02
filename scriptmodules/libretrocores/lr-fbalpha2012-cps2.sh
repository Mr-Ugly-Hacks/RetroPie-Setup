#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="lr-fbalpha2012-cps2"
rp_module_desc="Arcade emu - Final Burn Alpha (0.2.97.30) cps1 port for libretro"
rp_module_help="Previously called lr-fba\n\nROM Extension: .zip\n\nCopy your CPS1 roms to\n$romdir/cps1 ."
rp_module_licence="NONCOM https://raw.githubusercontent.com/libretro/fbalpha2012-cps1/master/docs/license.txt"
rp_module_repo="git https://github.com/libretro/fbalpha2012_cps2.git master"
rp_module_section="opt armv6=main"


function sources_lr-fbalpha2012-cps2() {
    gitPullOrClone
}

function build_lr-fbalpha2012-cps2() {
    make -f makefile.libretro clean
    local params=()
    isPlatform "arm" && params+=("platform=armv")
    make -f makefile.libretro "${params[@]}"
    md_ret_require="$md_build/fbalpha2012_cps2_libretro.so"
}

function install_lr-fbalpha2012-cps2() {
    md_ret_files=(
        'fbalpha2012_cps2_libretro.so'
        'gamelist.txt'
     )
}

function configure_lr-fbalpha2012-cps2() {
    local system
    for system in cps2; do
        mkRomDir "$system"
        ensureSystemretroconfig "$system"
        addEmulator 0 "$md_id" "$system" "$md_inst/fbalpha2012_cps2_libretro.so"
        addSystem "$system"
    done
}
