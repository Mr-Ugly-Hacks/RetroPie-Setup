#!/usr/bin/env bash

# This file is part of ARES by The RetroArena
#
# ARES is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/Retro-Arena/RetroArena-Setup/master/LICENSE.md
#
# Core script functionality is based upon The RetroPie Project https://retropie.org.uk Script Modules
#

rp_module_id="hypseus"
rp_module_desc="Hypseus a modern Daphne - Laserdisc Emulator fork"
rp_module_help="ROM Extension: .daphne\n\nCopy your Daphne roms to $romdir/hypseus"
rp_module_licence="GPL3 https://raw.githubusercontent.com/DirtBagXon/hypseus-singe/master/LICENSE"
rp_module_repo="git https://github.com/DirtBagXon/hypseus-singe.git master"
rp_module_section="exp"
rp_module_flags=""

function depends_hypseus() {
    getDepends libsdl2-dev libvorbis-dev libglew-dev zlib1g-dev cmake libogg-dev libftdi1-dev libmpeg2-4-dev
	}

function sources_hypseus() {
    gitPullOrClone
	
}

function build_hypseus() {
    mkdir build
    cd build
    cmake ../src
    make
	md_ret_require="$md_build/build/hypseus"
}

function install_hypseus() {
    md_ret_files=(
        "pics"
		"sound"
	    "/build/hypseus"   
        "/README.md"
		"fonts"
        
    )
}

function configure_hypseus() {
    mkRomDir "hypseus"
    mkRomDir "hypseus/roms"

  [[ "$md_mode" == "remove" ]] && return
    mkUserDir "$md_conf_root/hypseus"
    setDispmanx "$md_id" 1
    if [[ ! -f "$md_conf_root/hypseus/hypinput.ini" ]]; then
        cp -v "$md_data/hypinput.ini" "$md_conf_root/hypseus/hypinput.ini"
    fi
    ln -snf "$romdir/hypseus/roms" "$md_inst/roms"
    ln -sf "$md_conf_root/$md_id/hypinput.ini" "$md_inst/hypinput.ini"

    cat >"$md_inst/hypseus.sh" <<_EOF_
#!/bin/bash
dir="\$1"
name="\${dir##*/}"
name="\${name%.*}"

if [[ -f "\$dir/\$name.commands" ]]; then
    params=\$(<"\$dir/\$name.commands")
fi

"$md_inst/hypseus" "\$name" vldp -framefile "\$dir/\$name.txt" -homedir "$md_inst" -fullscreen -useoverlaysb 2   \$params
_EOF_
    chmod +x "$md_inst/hypseus.sh"
	
	chown -R $user:$user "$md_inst"
    chown -R $user:$user "$md_conf_root/hypseus/dapinput.ini"
    
    addEmulator 1 "$md_id" "hypseus" "$md_inst/hypseus.sh %ROM%"
	addSystem "hypseus"
}