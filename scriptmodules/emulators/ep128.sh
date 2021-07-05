#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="ep128emu"
rp_module_desc="Enterprise 128  Emulator for Linux"
rp_module_help="ROM Extensions:.img .tap .rom .bin \n\nCopy your Enterprise 128 games to to $romdir/ep128\n"
rp_module_licence="GPL2 https://raw.githubusercontent.com/istvan-v/ep128emu/master/COPYING"
rp_module_repo="git https://github.com/istvan-v/ep128emu.git master"
rp_module_section="exp"
rp_module_flags="!arm"

function depends_ep128emu() {
    getDepends scons  libfltk1.3-dev portaudio19-dev  libsndfile1-dev libcurlpp-dev
}

function sources_ep128emu() {
    gitPullOrClone
}

function build_ep128emu() {
    scons
    md_ret_require="$md_build/ep128emu"
}

function install_ep128emu() {
    md_ret_files=(
        'ep128emu'
		'epcompress'
		'epimgconv'
		'epmakecfg'
		'disk'
		'roms'
		'README'
		'COPYING'
		'maketranslation'
		'tapeedit'
		'config'
    )
}

function configure_ep128emu() {
    mkRomDir "ep128"
    mkUserDir "$md_conf_root/ep128"
		
	addEmulator 1 "${md_id}"  "ep128" "$md_inst/ep128emu -ep128 -snapshot %ROM%"
    
    addSystem "ep128"
	
}