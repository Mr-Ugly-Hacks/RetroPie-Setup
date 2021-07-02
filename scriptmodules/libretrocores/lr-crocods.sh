#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="lr-crocods"
rp_module_desc="Amstrad CPC emu - crocods port for libretro"
rp_module_help="ROM Extensions: .cdt .cpc .dsk\n\nCopy your Amstrad CPC games to $romdir/amstradcpc"
rp_module_licence="GPL2 https://raw.githubusercontent.com/libretro/libretro-crocods/master/crocods/COPYING.txt"
rp_module_repo="git https://github.com/libretro/libretro-crocods.git master"
rp_module_section="main"

function sources_lr-crocods() {
    gitPullOrClone
}

function build_lr-crocods() {
    make clean
    make
    md_ret_require="$md_build/crocods_libretro.so"
}

function install_lr-crocods() {
    md_ret_files=(
        'crocods_libretro.so'
    )
}

function configure_lr-crocods() {
    mkRomDir "amstradcpc"
    mkRomDir "amstradgx4000"
    ensureSystemretroconfig "amstradcpc"
    ensureSystemretroconfig "amstradgx4000"

    setRetroArchCoreOption "crocods_autorun" "enabled"
    setRetroArchCoreOption "crocods_Model" "6128"
    setRetroArchCoreOption "crocods_Ram" "128"
    setRetroArchCoreOption "crocods_combokey" "y"
	
	# force gx4000 system
	local core_config="$md_conf_root/amstradgx4000/retroarch-core-options.cfg"
	iniConfig " = " '"' "$md_conf_root/amstradgx4000/retroarch.cfg"
    iniSet "core_options_path" "$core_config"
	iniSet "crocods_autorun" "enabled" "$core_config"
    iniSet "crocods_model" "6128+" "$core_config"
    iniSet "crocods_ram" "128" "$core_config"
    iniSet "crocods_combokey" "y" "$core_config"
	chown $user:$user "$core_config"

    addEmulator 0 "$md_id" "amstradcpc" "$md_inst/crocods_libretro.so"
    addSystem "amstradcpc"
    addEmulator 0 "$md_id" "amstradgx4000" "$md_inst/crocods_libretro.so"
    addSystem "amstradgx4000"
	
}
