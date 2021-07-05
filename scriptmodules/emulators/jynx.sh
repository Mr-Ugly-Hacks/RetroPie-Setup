#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="jynx"
rp_module_desc="Camputers Lynx 48/96 emulator"
rp_module_help="ROM Extensions: .tap \n\nCopy your lynx 48/96 games to to $romdir/camplynx\n\nCopy bios files lynx48-1.rom lynx48-2.rom lynx96-1.rom lynx96-2.rom lynx96-3.rom lynx96-3-scorpion.rom to $biosdir/camplynx"
rp_module_repo="git https://github.com/jonathan-markland/Jynx.git master"
rp_module_section="exp"
rp_module_flags="!arm"

function depends_jynx() {
    getDepends libgtk2.0-dev libasound2-dev
}

function sources_jynx() {
    gitPullOrClone
}

function build_jynx() {
    cd ForLinux
	make -f makefile_X86 clean
	make -f makefile_X86
    md_ret_require="$md_build/ForLinux/bin/Release/Jynx"
}

function install_jynx() {
    md_ret_files=(
        'ForLinux/bin/Release/Jynx'
    )
}

function configure_jynx() {
    mkRomDir "jynx"
    mkUserDir "$md_conf_root/jynx"
	mkUserDir "$biosdir/jynx"
	ln -sf "$biosdir/camplynx/lynx48-1.rom" "$md_inst/lynx48-1.rom"
	ln -sf "$biosdir/camplynx/lynx48-2.rom" "$md_inst/lynx48-2.rom"
	ln -sf "$biosdir/camplynx/lynx96-1.rom" "$md_inst/lynx96-1.rom"
	ln -sf "$biosdir/camplynx/lynx96-2.rom" "$md_inst/lynx96-2.rom"
	ln -sf "$biosdir/camplynx/lynx96-3.rom" "$md_inst/lynx96-3.rom"
	ln -sf "$biosdir/camplynx/lynx96-3-scorpion.rom" "$md_inst/lynx96-3-scorpion.rom"
	
	addEmulator 1 "${md_id}-48k"  "camplynx" "$md_inst/Jynx --run %ROM%"
    
    addSystem "camplynx"
	
}
	