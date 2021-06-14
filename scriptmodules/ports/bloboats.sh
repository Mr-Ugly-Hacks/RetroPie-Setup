#!/usr/bin/env bash
 
# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#
 
rp_module_id="bloboats"
rp_module_desc="Bloboats"
rp_module_section="exp"
rp_module_flags="!mali"
 
function depends_bloboats() {
    getDepends cmake xorg
}

function install_bin_bloboats() {
    aptInstall bloboats
    }
 
function configure_bloboats() {
    mkdir "ports"
    moveConfigDir "$home/.bloboats" "$md_conf_root/bloboats"
    addPort "$md_id" "bloboats" "Bloboats" "bloboats"
}
