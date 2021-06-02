#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="play2"
rp_module_desc="Play! emulator play 2"
rp_module_help="ROM Extensions: .iso\n\nCopy your playstation 2 roms to $romdir/ps2"
rp_module_licence="BSD https://github.com/jpd002/Play-/blob/master/License.txt"
rp_module_section="exp"
rp_module_flags="!all x86"

function depends_play2() {
    getDepends cmake qtbase5-dev libsqlite3-dev libqt5x11extras5-dev libcurl4-openssl-dev libgl1-mesa-dev libglu1-mesa-dev libalut-dev libevdev-dev libgles2-mesa-dev
	
}

function sources_play2() {
    local branch="master"
    gitPullOrClone "$md_build" https://github.com/jpd002/Play- "$branch" 
    git submodule update -q --init --recursive

}

function build_play2() {
    cmake . -DCMAKE_INSTALL_PREFIX="$md_inst"
    make clean
    make
    md_ret_require="$md_build/Source/ui_qt/Play"
}

function install_play2() {
    make install
}

function configure_play2() {
    mkRomDir "ps2"
    moveConfigDir "$home/.play" "$md_conf_root/ps2"
    addEmulator 1 "$md_id" "ps2" "$md_inst/bin/Play --disc %ROM%"
    addSystem "ps2"
}
