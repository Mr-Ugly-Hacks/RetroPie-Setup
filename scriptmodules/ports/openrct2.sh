#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="openrct2"
rp_module_desc="OpenRCT2 is an open-source re-implementation of RollerCoaster Tycoon 2 (RCT2)."
rp_module_licence="GPL3 https://github.com/OpenRCT2/OpenRCT2/blob/v0.2.4/licence.txt"
rp_module_repo="git https://github.com/OpenRCT2/OpenRCT2.git v0.2.4"
rp_module_section="exp"
rp_module_flags=""

function depends_openrct2() {
    getDepends cmake libfreetype6-dev libfontconfig1-dev libzip-dev libspeexdsp-dev libcurl4-openssl-dev libjansson-dev libssl-dev libicu-dev zlib1g-dev
}

function sources_openrct2() {
    gitPullOrClone
}

function build_openrct2() {
    mkdir build
    cd build
    cmake ../ -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX="$md_inst"
	make
	md_ret_require="$md_build/build/openrct2"
    
}

function install_openrct2() {
    cd "$md_build/build"
    make install
    mkRomDir "ports/$md_id"
        ln -sfn "$md_inst/share/"  "$romdir/ports/$md_id/share"
		chown -R $user:$user "$md_inst/share/"
}

function configure_openrct2() {
     addPort "$md_id" "openrct2" "openrct2" "$md_inst/bin/openrct2"

   if  isPlatform "odroid-xu"; then
    local file="$romdir/ports/openrct2.sh"
    cat >"$file" << _EOF_
#!/bin/bash
sudo mv /etc/X11/xorg.bak /etc/X11/xorg.conf
pushd "$md_inst"
"$rootdir/supplementary/runcommand/runcommand.sh" 0 _PORT_ openrct2 ""
popd
sudo mv /etc/X11/xorg.conf /etc/X11/xorg.bak
_EOF_
else local file="$romdir/ports/openrct2.sh"
    cat >"$file" << _EOF_
#!/bin/bash
pushd "$md_inst"
"$rootdir/supplementary/runcommand/runcommand.sh" 0 _PORT_ openrct2 ""
popd
_EOF_
fi
    chown $user:$user "$file"
    chmod +x "$file"
}
	
	