#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="lr-vitaquake3"
rp_module_desc="Quake 3 engine - vitaquake3 port for libretro"
rp_module_licence="GPL2 https://raw.githubusercontent.com/libretro/vitaquake3/libretro/LICENSE"
rp_module_repo="git https://github.com/libretro/vitaquake3.git libretro "
rp_module_section="opt"

function sources_lr-vitaquake3() {
    gitPullOrClone
}

function build_lr-vitaquake3() {
    make clean
    make
    md_ret_require="$md_build/vitaquake3_libretro.so"
}

function install_lr-vitaquake3() {
    md_ret_files=(  
   'vitaquake3_libretro.so'
    )
}

function add_games_lr-vitaquake3() {
    local cmd="$1"
    declare -A games=(
        ['baseq2/pak0']="Quake II"
        ['rogue/pak0']="Quake II - Ground Zero"
        ['xatrix/pak0']="Quake II - The Reckoning"
    )

    local game
    local pak
    for game in "${!games[@]}"; do
        pak="$romdir/ports/quake2/$game.pak"
        if [[ -f "$pak" ]]; then
            addPort "$md_id" "quake2" "${games[$game]}" "$cmd" "${game%%/*}"
        fi
    done
}

function game_data_lr-vitaquake3() {
    if [[ ! -f "$romdir/ports/quake3/pak0.pk3" ]]; then
        downloadAndExtract "$__archive_url/Q3DemoPaks.zip" "$romdir/ports/quake3" -j
    fi
    # always chown as moveConfigDir in the configure_ script would move the root owned demo files
    chown -R $user:$user "$romdir/ports/quake3"
}

function configure_lr-vitaquake3() {
    mkRomDir "ports/quake3"
    addPort "$md_id" "quake3" "Quake III Arena"

    [[ "$md_mode" == "remove" ]] && return

    game_data_lr-vitaquake3

    moveConfigDir "$md_inst/baseq3" "$romdir/ports/quake3"
	ensureSystemretroconfig "ports/quake3"
}
