#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#
 
rp_module_id="monsterz"
rp_module_desc="monsterz - arcade puzzle game"
rp_module_licence="PROP"
rp_module_section="exp"
rp_module_flags="!mali !kms"

function depends_monsterz() {
    getDepends xorg matchbox monsterz-data
}

function install_bin_monsterz() {
    [[ -f "$md_inst/monsterz" ]] && rm -rf "$md_inst/"*
    aptInstall monsterz
}

function remove_monsterz() {
    aptRemove monsterz
}

function configure_monsterz() {
    addPort "$md_id" "monsterz" "monsterz" "xinit $md_inst/monsterz.sh"

    cat >"$md_inst/monsterz.sh" << _EOF_
#!/bin/bash
xset -dpms s off s noblank
matchbox-window-manager &
monsterz
_EOF_
    chmod +x "$md_inst/monsterz.sh"
}
