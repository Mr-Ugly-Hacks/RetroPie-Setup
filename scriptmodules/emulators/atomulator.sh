#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="atomulator"
rp_module_desc="Acorn atom Emulator for Linux"
rp_module_help="ROM Extensions: .bin .rom .wav .tap .uef .atm .zip .dsk .40t .fdi .td0 .imd .cqm .d77 .d88 .1dd .sh  \n\nCopy your atom games to to $romdir/atom\n"
rp_module_repo="git https://github.com/hoglet67/Atomulator.git master"
rp_module_section="exp"
rp_module_flags="!arm"

function depends_atomulator() {
    getDepends automake liballegro4-dev zlib1g-dev libalut-dev libopenal-dev
}

function sources_atomulator() {
    gitPullOrClone
}

function build_atomulator() {
    cd src
    make -f Makefile.linux
    md_ret_require="$md_build/Atomulator"
}

function install_atomulator() {
    md_ret_files=(
        'Atomulator'
		'roms'
		'mmc'
		'docs'
		'tools'
		'ddnoise'
    )
}

function configure_atomulator() {
    mkRomDir "atom"
    mkUserDir "$md_conf_root/atom"
	
    cat > "$romdir/atom/atomulator.sh" << _EOF_
    #!/usr/bin/env bash
	pushd "$md_inst"
    ./Atomulator
	popd
_EOF_
	
chmod a+x 	"$romdir/atom/atomulator.sh" 
	addEmulator 1 "${md_id}"  "atom" "$romdir/atom/atomulator.sh" 
    
    addSystem "atom"
	chown -R $user:$user "$md_inst" 
	
}