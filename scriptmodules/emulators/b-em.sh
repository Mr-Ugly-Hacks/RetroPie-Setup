#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="b-em"
rp_module_desc="Acorn BBC Micro Emulator for Linux"
rp_module_help="ROM Extensions: .ssd .wav .csw .uef .bin .rom .bbc .imd .dsd .fdi .td0 .cqm .dsk .d77 .d88 .1dd .hdf  \n\nCopy your BBC Micro games to to $romdir/bbcmicro\n"
rp_module_repo="git https://github.com/stardot/b-em.git master"
rp_module_section="exp"
rp_module_flags="!arm"

function depends_b-em() {
    getDepends liballegro5-dev  zlib1g-dev
}

function sources_b-em() {
    gitPullOrClone
}

function build_b-em() {
    ./autogen.sh
	./configure
    make
    md_ret_require="$md_build/b-em"
}

function install_b-em() {
    md_ret_files=(
        'b-em'
		'README.md'
		'hd4.hdf'
		'hd5.hdf'
		'ddnoise'
		'roms'
		'discs'
		'tapes'
    )
}

function configure_b-em() {
    mkRomDir "bbcmicro"
    mkUserDir "$md_conf_root/b-em"
		
	addEmulator 1 "${md_id}"  "bbcmicro" "$md_inst/b-em %ROM%"
    
    addSystem "bbcmicro"
	
}