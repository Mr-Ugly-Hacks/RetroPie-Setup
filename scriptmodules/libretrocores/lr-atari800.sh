#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="lr-atari800"
rp_module_desc="Atari 8-bit/800/5200 emulator - Atari800 port for libretro"
rp_module_help="ROM Extensions: .a52 .bas .bin .car .xex .atr .xfd .dcm .atr.gz .xfd.gz\n\nCopy your Atari800 games to $romdir/atari800\n\nCopy your Atari 5200 roms to $romdir/atari5200 You need to copy the Atari 800/5200 BIOS files (5200.ROM, ATARIBAS.ROM, ATARIOSB.ROM and ATARIXL.ROM) to the folder $biosdir"
rp_module_licence="GPL2 https://raw.githubusercontent.com/libretro/libretro-atari800/master/atari800/COPYING"
rp_module_repo="git https://github.com/libretro/libretro-atari800.git master"
rp_module_section="main"

function sources_lr-atari800() {
    gitPullOrClone
}

function build_lr-atari800() {
    make clean
    CFLAGS+=" -DDEFAULT_CFG_NAME=\\\".lr-atari800.cfg\\\"" make
    md_ret_require="$md_build/atari800_libretro.so"
}

function install_lr-atari800() {
    md_ret_files=(
        'atari800_libretro.so'
        'atari800/COPYING'
    )
}

function configure_lr-atari800() {
local system
    for system in atari800 atari5200 atarixegs; do
        mkRomDir "$system"

        ensureSystemretroconfig "$system"
        addEmulator 1 "$md_id" "$system" "$md_inst/atari800_libretro.so"
        addSystem "$system"
    done
	
# force Atari 800 system
    local core_config="$md_conf_root/atari800/retroarch-core-options.cfg"
    iniConfig " = " '"' "$md_conf_root/atari800/retroarch.cfg"
    iniSet "core_options_path" "$core_config"
    iniSet atari800_artifacting "disabled" "$core_config"
    iniSet atari800_cassboot "disabled" "$core_config"
    iniSet atari800_internalbasic "disabled" "$core_config"
    iniSet atari800_keyboard "poll" "$core_config"
    iniSet atari800_ntscpal "NTSC" "$core_config"
    iniSet atari800_opt1 "disabled" "$core_config"
    iniSet atari800_opt2 "disabled" "$core_config"
    iniSet atari800_resolution "336x240" "$core_config"
    iniSet atari800_sioaccel "disabled" "$core_config"
    iniSet atari800_system "400/800 (OS B)" "$core_config"
    chown $user:$user "$core_config"
	
# force Atari XE system
    local core_config="$md_conf_root/atarixegs/retroarch-core-options.cfg"
    iniConfig " = " '"' "$md_conf_root/atarixegs/retroarch.cfg"
    iniSet "core_options_path" "$core_config"
    iniSet atari800_artifacting "disabled" "$core_config"
    iniSet atari800_cassboot "disabled" "$core_config"
    iniSet atari800_internalbasic "disabled" "$core_config"
    iniSet atari800_keyboard "poll" "$core_config"
    iniSet atari800_ntscpal "NTSC" "$core_config"
    iniSet atari800_opt1 "disabled" "$core_config"
    iniSet atari800_opt2 "disabled" "$core_config"
    iniSet atari800_resolution "336x240" "$core_config"
    iniSet atari800_sioaccel "disabled" "$core_config"
    iniSet "atari800_system" "130XE (128K)" "$core_config"
    chown $user:$user "$core_config"
	
# force Atari 5200 system
    local core_config="$md_conf_root/atari5200/retroarch-core-options.cfg"
    iniConfig " = " '"' "$md_conf_root/atari5200/retroarch.cfg"
    iniSet "core_options_path" "$core_config"
    iniSet atari800_artifacting "enabled" "$core_config"
    iniSet atari800_cassboot "disabled" "$core_config"
    iniSet atari800_internalbasic "disabled" "$core_config"
    iniSet atari800_keyboard "poll" "$core_config"
    iniSet atari800_ntscpal "NTSC" "$core_config"
    iniSet atari800_opt1 "disabled" "$core_config"
    iniSet atari800_opt2 "disabled" "$core_config"
    iniSet atari800_resolution "336x240" "$core_config"
    iniSet atari800_sioaccel "enabled" "$core_config"
    iniSet atari800_system "5200" "$core_config"
    chown $user:$user "$core_config"

    mkUserDir "$md_conf_root/atari800"
    moveConfigFile "$home/.lr-atari800.cfg" "$md_conf_root/atari800/lr-atari800.cfg"

}
