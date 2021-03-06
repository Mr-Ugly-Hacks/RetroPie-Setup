#!/usr/bin/env bash

# This file is part of The RetroPie Project
# 
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
# 
# See the LICENSE.md file at the top-level directory of this distribution and 
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="devilutionx"
rp_module_desc="devilutionx - Diablo Engine"
rp_module_licence="https://raw.githubusercontent.com/diasurgical/devilutionX/master/LICENSE"
rp_module_repo="git https://github.com/diasurgical/devilutionX"
rp_module_help="Copy your original diabdat.mpq file from Diablo to $romdir/ports/devilutionx."
rp_module_section="exp"
rp_module_flags="!mali"

function depends_devilutionx() {
    getDepends cmake g++ libsdl2-mixer-dev libsdl2-ttf-dev libsodium-dev
}

function sources_devilutionx() {
    gitPullOrClone
}

function build_devilutionx() {
    cd build
    cmake -DVERSION_NUM=1.0.0 -DVERSION_SUFFIX=FFFFFFF -DCMAKE_BUILD_TYPE=Release CMAKE_INSTALL_PREFIX="$md_inst" ..
    make -j3
	md_ret_require="$md_build/build/devilutionx"
}

function install_devilutionx() {
    md_ret_files=(
          'build/devilutionx'
          'build/CharisSILB.ttf'
    )
    cp "$md_build/CharisSILB.ttf" "/usr/share/fonts/truetype/CharisSILB.ttf"

}

function configure_devilutionx() {
    mkRomDir "ports"
    mkRomDir "ports/devilutionx"

    addPort "$md_id" "devilutionx" "devilutionx - Diablo Engine" "$md_inst/devilutionx --data-dir $romdir/ports/devilutionx --save-dir $md_conf_root/devilutionx"
}
