#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="lr-craft"
rp_module_desc="Minecraft engine - Craft port for libretro"
rp_module_licence="MIT https://raw.githubusercontent.com/libretro/Craft/master/LICENSE.md"
rp_module_repo="git https://github.com/libretro/Craft.git"
rp_module_section="exp"
rp_module_flags="!gles gl" #for now the code break for opengl es 

function sources_lr-craft() {
    gitPullOrClone
}

function build_lr-craft() {
    make -f Makefile.libretro clean
    make -f Makefile.libretro 
    md_ret_require="$md_build/craft_libretro.so"
}

function install_lr-craft() {
    md_ret_files=(
        'craft_libretro.so'
    )
}

function configure_lr-craft() {
    setConfigRoot "ports"

    addPort "$md_id" "craft" "Craft" "$emudir/retroarch/bin/retroarch -L $md_inst/craft_libretro.so --config $md_conf_root/craft/retroarch.cfg"

    ensureSystemretroconfig "ports/craft"
}
