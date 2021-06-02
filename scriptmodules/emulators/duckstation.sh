#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="duckstation"
rp_module_desc="Playstation emulator"
rp_module_help="ROM Extensions: .bin/.cue \n\nCopy your PSX games to $romdir/psx"
rp_module_licence="GPL3 https://github.com/stenzek/duckstation/blob/master/LICENSE"
rp_module_repo="https://github.com/stenzek/duckstation.git master"
rp_module_section="exp"
rp_module_flags="!arm"


function depends_duckstation() {
    local depends=(libsdl2-dev libgtk2.0-dev)
    getDepends "${depends[@]}"
	}

function sources_duckstation() {
   gitPullOrClone
}

function build_duckstation() {
    mkdir build-release
    cd build-release
    cmake -DCMAKE_BUILD_TYPE=Release -DBUILD_QT_FRONTEND=ON .. #QT BUILD is some slower than SDL 
    make
    md_ret_require="$md_build/build-release/src/duckstation-sdl/duckstation-sdl"
    md_ret_require="$md_build/build-release/src/duckstation-qt/duckstation-qt"

}

function install_duckstation() {
        md_ret_files=(
        'build-release/src/duckstation-sdl/duckstation-sdl'
        'build-release/src/duckstation-qt/duckstation-qt'
      )
}

function install_bin_duckstation() {
    downloadAndExtract "$__gitbins_url/duckstation.tar.gz" "$md_inst" 1
}

function configure_duckstation() {
    mkRomDir "psx"
    mkdir -p "/home/aresuser/.local/share/duckstation/bios" #needed if not exist the directory i.e in the first executation.
    chown aresuser:aresuser -R /home/aresuser/.local/share/duckstation #needed change the user to aresuser instean root  
    moveConfigDir "/home/aresuser/.local/share/duckstation/bios" "/home/aresuser/ARES/BIOS/" 
    addEmulator 0 "$md_id-qt" "psx" "$md_inst/duckstation-qt"
    addEmulator 1 "$md_id-sdl" "psx" "$md_inst/duckstation-sdl %ROM%"
    addSystem "psx"
}
