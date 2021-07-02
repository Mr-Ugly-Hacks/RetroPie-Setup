#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="lr-sameboy"
rp_module_desc="Gameboy Color emu - sameboy port for libretro"
rp_module_help="ROM Extensions: .gb .gbc .zip\n\nCopy your GameBoy roms to $romdir/gb\n\nCopy your GameBoy Color roms to $romdir/gbc"
rp_module_licence="MIT https://github.com/libretro/SameBoy/blob/buildbot/LICENSE"
rp_module_repo="git https://github.com/libretro/SameBoy.git buildbot"
rp_module_section="exp"

function sources_lr-sameboy() {
    gitPullOrClone
}

function build_lr-sameboy() {
    cd libretro
	make clean
    make 
    md_ret_require="$md_build/libretro/sameboy_libretro.so"
}

function install_lr-sameboy() {
    md_ret_files=(
        '/libretro/sameboy_libretro.so'
    )
}

function configure_lr-sameboy() {
   
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
    addEmulator 0 "$md_id" "gb" "$md_inst/sameboy_libretro.so"
    addEmulator 0 "$md_id" "gbc" "$md_inst/sameboy_libretro.so"
	addEmulator 0 "$md_id" "gb-jp" "$md_inst/sameboy_libretro.so"
    addEmulator 0 "$md_id" "gbc-jp" "$md_inst/sameboy_libretro.so"
	addEmulator 0 "$md_id" "gbh" "$md_inst/sameboy_libretro.so"
    addEmulator 0 "$md_id" "gb-unl" "$md_inst/sameboy_libretro.so"
    addSystem "gb"
    addSystem "gbc"
	addSystem "gb-jp"
    addSystem "gbc-jp"
	addSystem "gbh"
    addSystem "gb-unl"
}
