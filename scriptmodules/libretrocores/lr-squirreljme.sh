#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="lr-squirreljme"
rp_module_desc="Java ME emulator - squirreljme port for libretro."
rp_module_help="ROM Extensions: .jar .zip .7z\n\nCopy your Java ME (J2ME) roms to $romdir/j2me\n\nThe BIOS files squirreljme-sdl.jar, squirreljme.jar and squirreljme-lr.jar will automatically installed in $biosdir"
rp_module_licence="GPL3 https://raw.githubusercontent.com/SquirrelJME/SquirrelJME/trunk/LICENSE"
rp_module_repo="git https://github.com/XerTheSquirrel/SquirrelJME.git trunk"
rp_module_section="exp"
rp_module_flags="" 

function depends_lr-squirreljme() {
    local depends=(openjdk-11-jre ant)
    getDepends "${depends[@]}"    
}

function sources_lr-squirreljme() {
    gitPullOrClone
}

function build_lr-squirreljme() {
    ant
    cd "ratufacoat"
    make clean
    make -f makefilelibretro 
    md_ret_require="$md_build/ratufacoat/squirreljme_libretro.so"
}

function install_lr-squirreljme() {
    md_ret_files=(
	'/ratufacoat/squirreljme_libretro.so'
    )
}

function configure_lr-squirreljme() {
    mkRomDir "j2me"
    ensureSystemretroconfig "j2me"

    addEmulator 0 "$md_id" "j2me" "$md_inst/squirreljme_libretro.so"
    addSystem "j2me"
}