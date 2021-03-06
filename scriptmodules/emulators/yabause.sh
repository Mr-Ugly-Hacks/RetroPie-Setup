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

rp_module_id="yabause"
rp_module_desc="Sega Saturn Emulator"
rp_module_help="ROM Extensions: .iso .bin .zip\n\nCopy your Sega Saturn roms to $romdir/saturn\n\nCopy the required BIOS file saturn_bios_us.bin and saturn_bios_jp.bin to $biosdir"
rp_module_licence="https://github.com/devmiyax/yabause/blob/minimum_linux/yabause/COPYING"
rp_module_section="sa"
rp_module_flags="!rpi !videocore"

function depends_yabause() {
    local depends=(cmake libgles2-mesa-dev libsdl2-dev libboost-filesystem-dev libboost-system-dev libboost-locale-dev libboost-date-time-dev)
    getDepends "${depends[@]}"
	
	if isPlatform "odroid-n2"; then
	/home/aresuser/ARES-Setup/fixmali.sh
    elif isPlatform "rockpro64"; then
    /usr/lib/arm-linux-gnueabihf/install_mali.sh
	fi
	
}

function sources_yabause() {    
    gitPullOrClone "$md_build" https://github.com/devmiyax/yabause.git master
}

function build_yabause() {
    mkdir build
    cd build
    if isPlatform "odroid-n2"; then
        export CFLAGS="-O2 -march=armv8-a+crc -mtune=cortex-a73.cortex-a53 -ftree-vectorize -funsafe-math-optimizations -pipe"
        cmake ../yabause -DYAB_PORTS=retro_arena -DYAB_WANT_DYNAREC_DEVMIYAX=ON -DCMAKE_TOOLCHAIN_FILE=../yabause/src/retro_arena/n2.cmake
    elif isPlatform "odroid-xu"; then
        export CFLAGS="-O2 -march=armv7-a -mtune=cortex-a15.cortex-a7 -mfpu=neon-vfpv4 -mfloat-abi=hard -ftree-vectorize -funsafe-math-optimizations"
        cmake ../yabause -DYAB_PORTS=retro_arena -DYAB_WANT_DYNAREC_DEVMIYAX=ON -DYAB_WANT_ARM7=ON -DCMAKE_TOOLCHAIN_FILE=../yabause/src/retro_arena/xu4.cmake
		elif isPlatform "tinker"; then
        export CFLAGS="-O2 -march=armv7-a -mtune=cortex-a17 -mfloat-abi=hard -ftree-vectorize -funsafe-math-optimizations"
        cmake ../yabause -DYAB_PORTS=retro_arena -DYAB_WANT_DYNAREC_DEVMIYAX=ON -DYAB_WANT_ARM7=ON -DCMAKE_TOOLCHAIN_FILE=../yabause/src/retro_arena/xu4.cmake
    elif isPlatform "rockpro64"; then       
        export CFLAGS="-O2 -march=armv8-a+crc -mtune=cortex-a72.cortex-a53 -mfloat-abi=hard -ftree-vectorize -funsafe-math-optimizations -pipe"
        cmake ../yabause -DYAB_PORTS=retro_arena -DYAB_WANT_DYNAREC_DEVMIYAX=ON -DYAB_WANT_ARM7=ON -DCMAKE_TOOLCHAIN_FILE=../yabause/src/retro_arena/rp64.cmake
    elif isPlatform "jetson-nano"; then
        cmake ../yabause -DGIT_EXECUTABLE=/usr/bin/git -DYAB_PORTS=retro_arena -DYAB_WANT_DYNAREC_DEVMIYAX=ON -DCMAKE_TOOLCHAIN_FILE=../yabause/src/retro_arena/jetson.cmake 
    fi
    make
    md_ret_require="$md_build/build/src/retro_arena/yabasanshiro"
}

function install_yabause() {
    md_ret_files=(
        'build/src/retro_arena/yabasanshiro'
    )
}


function configure_yabause() {
    mkRomDir "saturn"
    addEmulator 0 "${md_id}-720p" "saturn" "$md_inst/yabasanshiro -a -nf -r 4 -i %ROM%"
    addEmulator 1 "${md_id}-720p-frameskip" "saturn" "$md_inst/yabasanshiro -a -r 4 -i %ROM%"
    addEmulator 0 "${md_id}-720p-bios" "saturn" "$md_inst/yabasanshiro -a -nf -r 4 -b /home/aresuser/ARES/BIOS/saturn_bios.bin -i %ROM%"
    addEmulator 0 "${md_id}-720p-bios-frameskip" "saturn" "$md_inst/yabasanshiro -a -r 4 -b /home/aresuser/ARES/BIOS/saturn_bios.bin -i %ROM%"
    addEmulator 0 "${md_id}-1x-bios" "saturn" "$md_inst/yabasanshiro -a -nf -r 3 -b /home/aresuser/ARES/BIOS/saturn_bios.bin -i %ROM%"
	addEmulator 0 "${md_id}-1x-bios-frameskip" "saturn" "$md_inst/yabasanshiro -a -r 3 -b /home/aresuser/ARES/BIOS/saturn_bios.bin -i %ROM%"
	addEmulator 0 "${md_id}-1x" "saturn" "$md_inst/yabasanshiro -a -nf -r 3 -i %ROM%"
	addEmulator 0 "${md_id}-1x-frameskip" "saturn" "$md_inst/yabasanshiro -a -r 3 -i %ROM%"
	addSystem "saturn"
	
}
