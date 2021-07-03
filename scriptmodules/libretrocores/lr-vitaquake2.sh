#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="lr-vitaquake2"
rp_module_desc="Quake 2 engine - vitaquake2 port for libretro"
rp_module_licence="GPL2 https://raw.githubusercontent.com/libretro/vitaquake2/libretro/LICENSE"
rp_module_repo="git https://github.com/libretro/vitaquake2.git libretro "
rp_module_section="opt"

function sources_lr-vitaquake2() {
    gitPullOrClone
}

function build_lr-vitaquake2() {
    make clean
    make
    md_ret_require="$md_build/vitaquake2_libretro.so"
}

function install_lr-vitaquake2() {
    md_ret_files=(
       'vitaquake2_libretro.so'
    )
}

function add_games_lr-vitaquake2() {
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

function game_data_lr-vitaquake2() {
    local unwanted

    if [[ ! -f "$romdir/ports/quake2/baseq2/pak1.pak" && ! -f "$romdir/ports/quake2/baseq2/pak0.pak" ]]; then
        # get shareware game data
        downloadAndExtract "https://deponie.yamagi.org/quake2/idstuff/q2-314-demo-x86.exe" "$romdir/ports/quake2/baseq2" -j -LL
    fi

    # remove files that are likely to cause conflicts or unwanted default settings
    for unwanted in $(find "$romdir/ports/quake2" -maxdepth 2 -name "*.so" -o -name "*.cfg" -o -name "*.dll" -o -name "*.exe"); do
        rm -f "$unwanted"
    done

    chown -R $user:$user "$romdir/ports/quake2"
}

function configure_lr-vitaquake2() {
    setConfigRoot "ports"
    mkRomDir "ports/quake"

    [[ "$md_mode" == "install" ]] && game_data_lr-vitaquake2

    add_games_lr-vitaquake2
    game_data_lr-vitaquake2
    ensureSystemretroconfig "ports/quake2"
}
