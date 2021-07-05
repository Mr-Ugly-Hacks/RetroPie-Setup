#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="elkulator"
rp_module_desc="Acorn Electron Emulator for Linux"
rp_module_help="ROM Extensions: .uef .wav .bin  \n\nCopy your electron games to to $romdir/electron\n\nCopy bios files adfs.rom basic.rom dfs.rom os os300.rom plus1.rom sndrom to $biosdir/electron"
rp_module_repo="git https://github.com/stardot/elkulator.git master"
rp_module_section="exp"
rp_module_flags="!arm"

function depends_elkulator() {
    getDepends automake liballegro4-dev zlib1g-dev libalut-dev libopenal-dev
}

function sources_elkulator() {
    gitPullOrClone
}

function build_elkulator() {
    aclocal -I m4
    automake -a
    autoconf
	./configure
    make
    md_ret_require="$md_build/elkulator"
}

function install_elkulator() {
    md_ret_files=(
        'elkulator'
		'readme.txt'
		'README'
		'Readme-LINUX.txt'
		'Readme-ROMS.txt'
		'ddnoise'
    )
}

function configure_elkulator() {
    mkRomDir "electron"
    mkUserDir "$md_conf_root/electron"
	mkUserDir "$biosdir/electron"
	ln -sf "$biosdir/electron" "$md_inst/roms"
	
	
	addEmulator 1 "${md_id}"  "electron" "$md_inst/elkulator %ROM%"
    
    addSystem "electron"
	
}