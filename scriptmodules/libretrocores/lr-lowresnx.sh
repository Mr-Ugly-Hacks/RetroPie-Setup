#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="lr-lowresnx"
rp_module_desc="A simulated retro game console, which can be programmed in the classic BASIC language port for libretro."
rp_module_help="ROM Extensions: .nx\n\nCopy your ROM files to $romdir/lowresnx"
rp_module_licence="ZLIB https://raw.githubusercontent.com/timoinutilis/lowres-nx/master/LICENSE"
rp_module_repo="git https://github.com/timoinutilis/lowres-nx.git retroarch"
rp_module_section="exp"
rp_module_flags=""

function sources_lr-lowresnx() {
    gitPullOrClone
}

function build_lr-lowresnx() {

    cd "$md_build/platform/LibRetro" 
    make
   	md_ret_require="$md_build/platform/LibRetro/lowresnx_libretro.so"
}
	
function install_lr-lowresnx() {
    md_ret_files=(
        '/platform/LibRetro/lowresnx_libretro.so'
    )
}

function configure_lr-lowresnx() {
    
	addEmulator 1 "$md_id" "lowresnx" "$md_inst/lowresnx_libretro.so"
    addSystem "lowresnx"
    
	mkRomDir "lowresnx"
    ensureSystemretroconfig "lowresnx"
}