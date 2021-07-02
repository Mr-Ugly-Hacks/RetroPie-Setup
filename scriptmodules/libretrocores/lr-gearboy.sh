#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="lr-gearboy"
rp_module_desc="Gameboy Color emu - gearboy port for libretro"
rp_module_help="ROM Extensions: .gb .gbc .zip\n\nCopy your GameBoy roms to $romdir/gb\n\nCopy your GameBoy Color roms to $romdir/gbc"
rp_module_licence="GPL3 https://github.com/drhelius/Gearboy/blob/master/LICENSE"
rp_module_repo="git https://github.com/drhelius/Gearboy.git master"
rp_module_section="exp"

function sources_lr-gearboy() {
    gitPullOrClone
}

function build_lr-gearboy() {
    cd "platforms/libretro"
	make  clean
    make
    md_ret_require="platforms/libretro/gearboy_libretro.so"
}

function install_lr-gearboy() {
    md_ret_files=(
       
        'platforms/libretro/gearboy_libretro.so'
    )
}

function configure_lr-gearboy() {
    
    mkRomDir "gbc"
    mkRomDir "gb"
	mkRomDir "gbh"
    mkRomDir "gb-jp"
	mkRomDir "gbc-jp"
    mkRomDir "gb-unl"
    ensureSystemretroconfig "gb"
    ensureSystemretroconfig "gbc"
	ensureSystemretroconfig "gbh"
    ensureSystemretroconfig "gbc-jp"
	ensureSystemretroconfig "gb-jp"
    ensureSystemretroconfig "gb-unl"
    addEmulator 0 "$md_id" "gb" "$md_inst/gearboy_libretro.so"
    addEmulator 0 "$md_id" "gbc" "$md_inst/gearboy_libretro.so"
	addEmulator 0 "$md_id" "gb-jp" "$md_inst/gearboy_libretro.so"
    addEmulator 0 "$md_id" "gbc-jp" "$md_inst/gearboy_libretro.so"
	addEmulator 0 "$md_id" "gbh" "$md_inst/gearboy_libretro.so"
    addEmulator 0 "$md_id" "gb-unl" "$md_inst/gearboy_libretro.so"
    addSystem "gb"
    addSystem "gbc"
	addSystem "gb-jp"
    addSystem "gbc-jp"
	addSystem "gbh"
    addSystem "gb-unl"
}
