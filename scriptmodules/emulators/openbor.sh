#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="openbor"
rp_module_desc="OpenBOR (v6510) - Beat 'em Up Game Engine"
rp_module_help="Place your pak files in $romdir/openbor and launch from ES.\n\nUse a keyboard to initially configure a gamepad."
rp_module_licence="BSD https://raw.githubusercontent.com/rofl0r/openbor/master/LICENSE"
rp_module_repo="git https://github.com/rofl0r/openbor.git master"
rp_module_section="opt"
rp_module_flags="!arm"

function depends_openbor() {
    getDepends libsdl2-gfx-dev libvorbisidec-dev libvpx-dev libogg-dev libsdl2-gfx-1.0-0 libvorbisidec1
	
	}

function sources_openbor() {
    gitPullOrClone
}

function build_openbor() {
    make clean
	make
    cd "$md_build/tools/borpak/"
    ./build-linux.sh
      
}

function install_openbor() {
    md_ret_files=(
       'OpenBOR'
       'tools/borpak/borpak'
       'tools/unpack.sh'
    )
}

function configure_openbor() {
    mkRomDir "openbor"
    mkUserDir "$configdir/openbor/ScreenShots"
    mkUserDir "$configdir/openbor/Saves"
    addSystem "openbor"
	chown -R $user:$user "$romdir/openbor/"
    addEmulator 1 "$md_id" "openbor" "pushd $md_inst; $md_inst/openbor %ROM%; popd"
    mv "$md_inst/OpenBOR" "$md_inst/openbor"
    ln -snf "/dev/shm" "$md_inst/Logs"
    ln -snf "$datadir/roms/openbor" "$md_inst/Paks"
    ln -snf "$configdir/openbor/ScreenShots" "$md_inst/ScreenShots"
    ln -snf "$configdir/openbor/Saves" "$md_inst/Saves"
}
