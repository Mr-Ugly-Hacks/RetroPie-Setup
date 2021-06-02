#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="open-omf2097"
rp_module_desc="Open OMF2097: One Must Fall 2097 Port to linux"
rp_module_licence="MIT https://raw.githubusercontent.com/omf2097/openomf/master/LICENSE"
rp_module_repo="git https://github.com/omf2097/openomf.git"
rp_module_section="exp"
rp_module_flags=""


function depends_open-omf2097() {
    ! isPlatform "x11" && getDepends xorg
	getDepends libsdl2-dev libopenal-dev libconfuse-dev libenet-dev libargtable2-dev libxmp-dev libogg-dev libvorbis-dev libpng-dev p7zip p7zip-full
}

function sources_open-omf2097() {
    gitPullOrClone
}

function build_open-omf2097() {
    mkdir build
	cd build
    cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX="$md_inst" ..
    make
	md_ret_require="$md_build/build/openomf"
    
}

function install_open-omf2097() {
    cd "$md_build/build"
    make install
    ln -sfn "$md_inst/share/games/openomf"  "$romdir/ports/$md_id"
	chown -R $user:$user "$md_inst/share/games/openomf"
	wget "http://www.omf2097.com/pub/files/omf/omf2097.rar" -P "$md_inst/share/games/openomf/"
    unrar e "$md_inst/share/games/openomf/omf2097.rar" "$md_inst/share/games/openomf/"
	rm "$md_inst/share/games/openomf/omf2097.rar"
	
	
}

function configure_open-omf2097() {
            addPort "$md_id" "open-omf2097" "open-omf2097" "$md_inst/bin/openomf"
                
    }
