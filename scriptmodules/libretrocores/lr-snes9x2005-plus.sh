#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="lr-snes9x2005-plus"
rp_module_desc="Super Nintendo emu - Snes9x 1.43 based port for libretro"
rp_module_help="Previously called lr-catsfc\n\nROM Extensions: .bin .smc .sfc .fig .swc .mgd .zip\n\nCopy your SNES roms to $romdir/snes"
rp_module_licence="NONCOM https://raw.githubusercontent.com/libretro/snes9x2005/master/copyright"
rp_module_repo="git https://github.com/libretro/snes9x2005.git master"
rp_module_section="exp"


function sources_lr-snes9x2005-plus() {
    gitPullOrClone
}

function build_lr-snes9x2005-plus() {
    make clean
    make USE_BLARGG_APU=1
    md_ret_require="$md_build/snes9x2005_plus_libretro.so"
}

function install_lr-snes9x2005-plus() {
    md_ret_files=(
        'snes9x2005_plus_libretro.so'
    )
}

function configure_lr-snes9x2005-plus() {
    local system
    for system in snes snesh sfc sufami satellaview; do
        mkRomDir "$system"
        ensureSystemretroconfig "$system"

        addEmulator 0 "$md_id" "$system" "$md_inst/snes9x2005_plus_libretro.so"
        addSystem "$system"
done
}
