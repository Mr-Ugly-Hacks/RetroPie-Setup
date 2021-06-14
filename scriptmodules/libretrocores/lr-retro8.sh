#!/usr/bin/env bash

# This file is part of ARES by The RetroArena
#
# ARES is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/Retro-Arena/RetroArena-Setup/master/LICENSE.md
#
# Core script functionality is based upon The RetroPie Project https://retropie.org.uk Script Modules
#

rp_module_id="lr-retro8"
rp_module_desc="PICO-8 fantasy console port for libretro"
rp_module_help="ROM Extensions: .p8 .png\n\nCopy your ROM files to $romdir/ports/pico8"
rp_module_licence="GPL3 https://raw.githubusercontent.com/Jakz/retro8/master/LICENSE"
rp_module_repo="git https://github.com/Jakz/retro8.git"
rp_module_section="exp"
rp_module_flags=""

function depends_lr-retro8() {
    local depends=(libsdl2-dev liblua5.3-dev zlib1g-dev)
    getDepends "${depends[@]}"
}

function sources_lr-retro8() {
    gitPullOrClone
}

function build_lr-retro8() {
    make clean
    make 
    md_ret_require="$md_build/retro8_libretro.so"
}

function install_lr-retro8() {
    md_ret_files=(
	'retro8_libretro.so'
	'LICENSE'
    )
}

function configure_lr-retro8() {
    
     addEmulator 1 "$md_id" "pico8" "$md_inst/retro8_libretro.so"
     addSystem "pico8"   
	
    mkRomDir "pico8"
    ensureSystemretroconfig "pico8"
}