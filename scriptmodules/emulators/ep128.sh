#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="ep128emu"
rp_module_desc="Enterprise 128  Emulator for Linux"
rp_module_help="ROM Extensions:.img .tap .rom .bin .bas .dtf .com .prg\n\nCopy your Enterprise 128 games to to $romdir/ep128\n"
rp_module_licence="GPL2 https://raw.githubusercontent.com/istvan-v/ep128emu/master/COPYING"
rp_module_repo="git https://github.com/istvan-v/ep128emu.git master"
rp_module_section="exp"
rp_module_flags="!arm"

function depends_ep128emu() {
    getDepends scons  libfltk1.3-dev portaudio19-dev  libsndfile1-dev libcurlpp-dev
}

function sources_ep128emu() {
    gitPullOrClone
}

function build_ep128emu() {
    scons
    md_ret_require="$md_build/ep128emu"
}

function install_ep128emu() {
    md_ret_files=(
        'ep128emu'
		'epcompress'
		'epimgconv'
		'epmakecfg'
		'disk'
		'roms'
		'README'
		'COPYING'
		'maketranslation'
		'tapeedit'
		'config'
    )
}

function configure_ep128emu() {
    mkRomDir "ep128"
    mkUserDir "$md_conf_root/ep128"
		
	addEmulator 1 "${md_id}"  "ep128" "$md_inst/ep128emu -ep128 -cfg /opt/retropie/emulators/ep128emu/config.cfg floppy.a.imageFile=%ROM%"
    
    addSystem "ep128"
	chown -R $user:$user "$md_inst" 
	
	cat > "$md_inst/config.cfg" << _EOF_
    compressFiles	Yes
debug.bpPriorityThreshold	0
display.blendScale	1
display.blue.brightness	0
display.blue.contrast	1
display.blue.gamma	1
display.brightness	0
display.bufferingMode	2
display.contrast	1
display.enabled	Yes
display.gamma	1
display.green.brightness	0
display.green.contrast	1
display.green.gamma	1
display.height	986
display.hueShift	0
display.lineShade	0.75
display.motionBlur	0.2
display.pixelAspectRatio	1
display.quality	3
display.red.brightness	0
display.red.contrast	1
display.red.gamma	1
display.saturation	1
display.width	1848
fileio.workingDirectory	"/home/pi/RetroPie/roms/ep128/file"
floppy.a.imageFile	
floppy.a.sectorsPerTrack	-1
floppy.a.sides	-1
floppy.a.tracks	-1
floppy.b.imageFile	""
floppy.b.sectorsPerTrack	-1
floppy.b.sides	-1
floppy.b.tracks	-1
floppy.c.imageFile	""
floppy.c.sectorsPerTrack	-1
floppy.c.sides	-1
floppy.c.tracks	-1
floppy.d.imageFile	""
floppy.d.sectorsPerTrack	-1
floppy.d.sides	-1
floppy.d.tracks	-1
ide.imageFile0	""
ide.imageFile1	""
ide.imageFile2	""
ide.imageFile3	""
joystick.autoFireFrequency	8
joystick.autoFirePulseWidth	0.5
joystick.axisThreshold	0.5
joystick.enableAutoFire	No
joystick.enableJoystick	Yes
joystick.enablePWM	No
joystick.pwmFrequency	17.5
keyboard.00.0	110
keyboard.00.1	-1
keyboard.01.0	92
keyboard.01.1	-1
keyboard.02.0	98
keyboard.02.1	-1
keyboard.03.0	99
keyboard.03.1	-1
keyboard.04.0	118
keyboard.04.1	-1
keyboard.05.0	120
keyboard.05.1	-1
keyboard.06.0	122
keyboard.06.1	-1
keyboard.07.0	65505
keyboard.07.1	-1
keyboard.08.0	104
keyboard.08.1	-1
keyboard.09.0	65509
keyboard.09.1	-1
keyboard.0A.0	103
keyboard.0A.1	-1
keyboard.0B.0	100
keyboard.0B.1	-1
keyboard.0C.0	102
keyboard.0C.1	-1
keyboard.0D.0	115
keyboard.0D.1	-1
keyboard.0E.0	97
keyboard.0E.1	-1
keyboard.0F.0	65507
keyboard.0F.1	65508
keyboard.10.0	117
keyboard.10.1	-1
keyboard.11.0	113
keyboard.11.1	-1
keyboard.12.0	121
keyboard.12.1	-1
keyboard.13.0	114
keyboard.13.1	-1
keyboard.14.0	116
keyboard.14.1	-1
keyboard.15.0	101
keyboard.15.1	-1
keyboard.16.0	119
keyboard.16.1	-1
keyboard.17.0	65289
keyboard.17.1	-1
keyboard.18.0	55
keyboard.18.1	-1
keyboard.19.0	49
keyboard.19.1	-1
keyboard.1A.0	54
keyboard.1A.1	-1
keyboard.1B.0	52
keyboard.1B.1	-1
keyboard.1C.0	53
keyboard.1C.1	-1
keyboard.1D.0	51
keyboard.1D.1	-1
keyboard.1E.0	50
keyboard.1E.1	-1
keyboard.1F.0	65307
keyboard.1F.1	-1
keyboard.20.0	65473
keyboard.20.1	-1
keyboard.21.0	65477
keyboard.21.1	-1
keyboard.22.0	65472
keyboard.22.1	-1
keyboard.23.0	65475
keyboard.23.1	-1
keyboard.24.0	65474
keyboard.24.1	-1
keyboard.25.0	65476
keyboard.25.1	-1
keyboard.26.0	65471
keyboard.26.1	-1
keyboard.27.0	65470
keyboard.27.1	-1
keyboard.28.0	56
keyboard.28.1	-1
keyboard.29.0	-1
keyboard.29.1	-1
keyboard.2A.0	57
keyboard.2A.1	-1
keyboard.2B.0	45
keyboard.2B.1	-1
keyboard.2C.0	48
keyboard.2C.1	-1
keyboard.2D.0	61
keyboard.2D.1	-1
keyboard.2E.0	65288
keyboard.2E.1	-1
keyboard.2F.0	-1
keyboard.2F.1	-1
keyboard.30.0	106
keyboard.30.1	-1
keyboard.31.0	-1
keyboard.31.1	-1
keyboard.32.0	107
keyboard.32.1	-1
keyboard.33.0	59
keyboard.33.1	-1
keyboard.34.0	108
keyboard.34.1	-1
keyboard.35.0	39
keyboard.35.1	-1
keyboard.36.0	93
keyboard.36.1	-1
keyboard.37.0	-1
keyboard.37.1	-1
keyboard.38.0	65377
keyboard.38.1	65367
keyboard.39.0	65364
keyboard.39.1	-1
keyboard.3A.0	65363
keyboard.3A.1	-1
keyboard.3B.0	65362
keyboard.3B.1	-1
keyboard.3C.0	65299
keyboard.3C.1	65360
keyboard.3D.0	65361
keyboard.3D.1	-1
keyboard.3E.0	65293
keyboard.3E.1	-1
keyboard.3F.0	65514
keyboard.3F.1	65027
keyboard.40.0	109
keyboard.40.1	-1
keyboard.41.0	65535
keyboard.41.1	-1
keyboard.42.0	44
keyboard.42.1	-1
keyboard.43.0	47
keyboard.43.1	-1
keyboard.44.0	46
keyboard.44.1	-1
keyboard.45.0	65506
keyboard.45.1	-1
keyboard.46.0	32
keyboard.46.1	-1
keyboard.47.0	65379
keyboard.47.1	-1
keyboard.48.0	105
keyboard.48.1	-1
keyboard.49.0	-1
keyboard.49.1	-1
keyboard.4A.0	111
keyboard.4A.1	-1
keyboard.4B.0	96
keyboard.4B.1	-1
keyboard.4C.0	112
keyboard.4C.1	-1
keyboard.4D.0	91
keyboard.4D.1	-1
keyboard.4E.0	-1
keyboard.4E.1	-1
keyboard.4F.0	-1
keyboard.4F.1	-1
keyboard.50.0	-1
keyboard.50.1	-1
keyboard.51.0	-1
keyboard.51.1	-1
keyboard.52.0	-1
keyboard.52.1	-1
keyboard.53.0	-1
keyboard.53.1	-1
keyboard.54.0	-1
keyboard.54.1	-1
keyboard.55.0	-1
keyboard.55.1	-1
keyboard.56.0	-1
keyboard.56.1	-1
keyboard.57.0	-1
keyboard.57.1	-1
keyboard.58.0	-1
keyboard.58.1	-1
keyboard.59.0	-1
keyboard.59.1	-1
keyboard.5A.0	-1
keyboard.5A.1	-1
keyboard.5B.0	-1
keyboard.5B.1	-1
keyboard.5C.0	-1
keyboard.5C.1	-1
keyboard.5D.0	-1
keyboard.5D.1	-1
keyboard.5E.0	-1
keyboard.5E.1	-1
keyboard.5F.0	-1
keyboard.5F.1	-1
keyboard.60.0	-1
keyboard.60.1	-1
keyboard.61.0	-1
keyboard.61.1	-1
keyboard.62.0	-1
keyboard.62.1	-1
keyboard.63.0	-1
keyboard.63.1	-1
keyboard.64.0	-1
keyboard.64.1	-1
keyboard.65.0	-1
keyboard.65.1	-1
keyboard.66.0	-1
keyboard.66.1	-1
keyboard.67.0	-1
keyboard.67.1	-1
keyboard.68.0	-1
keyboard.68.1	-1
keyboard.69.0	-1
keyboard.69.1	-1
keyboard.6A.0	-1
keyboard.6A.1	-1
keyboard.6B.0	-1
keyboard.6B.1	-1
keyboard.6C.0	-1
keyboard.6C.1	-1
keyboard.6D.0	-1
keyboard.6D.1	-1
keyboard.6E.0	-1
keyboard.6E.1	-1
keyboard.6F.0	-1
keyboard.6F.1	-1
keyboard.70.0	65465
keyboard.70.1	49153
keyboard.71.0	65463
keyboard.71.1	49152
keyboard.72.0	65461
keyboard.72.1	49155
keyboard.73.0	65455
keyboard.73.1	49154
keyboard.74.0	65451
keyboard.74.1	49168
keyboard.75.0	-1
keyboard.75.1	-1
keyboard.76.0	-1
keyboard.76.1	-1
keyboard.77.0	-1
keyboard.77.1	-1
keyboard.78.0	65462
keyboard.78.1	49157
keyboard.79.0	65460
keyboard.79.1	49156
keyboard.7A.0	65458
keyboard.7A.1	49159
keyboard.7B.0	65464
keyboard.7B.1	49158
keyboard.7C.0	65456
keyboard.7C.1	49169
keyboard.7D.0	-1
keyboard.7D.1	-1
keyboard.7E.0	-1
keyboard.7E.1	-1
keyboard.7F.0	-1
keyboard.7F.1	-1
memory.configFile	""
memory.ram.size	128
memory.rom.00.file	"/home/pi/.ep128emu/roms/exos21.rom"
memory.rom.00.offset	0
memory.rom.01.file	"/home/pi/.ep128emu/roms/exos21.rom"
memory.rom.01.offset	16384
memory.rom.02.file	""
memory.rom.02.offset	0
memory.rom.03.file	""
memory.rom.03.offset	0
memory.rom.04.file	"/home/pi/.ep128emu/roms/basic21.rom"
memory.rom.04.offset	0
memory.rom.05.file	""
memory.rom.05.offset	0
memory.rom.06.file	""
memory.rom.06.offset	0
memory.rom.07.file	""
memory.rom.07.offset	0
memory.rom.10.file	"/home/pi/.ep128emu/roms/epfileio.rom"
memory.rom.10.offset	0
memory.rom.11.file	""
memory.rom.11.offset	0
memory.rom.12.file	""
memory.rom.12.offset	0
memory.rom.13.file	""
memory.rom.13.offset	0
memory.rom.20.file	"/home/pi/.ep128emu/roms/exdos14isdos10uk.rom"
memory.rom.20.offset	0
memory.rom.21.file	"/home/pi/.ep128emu/roms/exdos14isdos10uk.rom"
memory.rom.21.offset	16384
memory.rom.22.file	""
memory.rom.22.offset	0
memory.rom.23.file	""
memory.rom.23.offset	0
memory.rom.30.file	""
memory.rom.30.offset	0
memory.rom.31.file	""
memory.rom.31.offset	0
memory.rom.32.file	""
memory.rom.32.offset	0
memory.rom.33.file	""
memory.rom.33.offset	0
memory.rom.40.file	""
memory.rom.40.offset	0
memory.rom.41.file	""
memory.rom.41.offset	0
memory.rom.42.file	""
memory.rom.42.offset	0
memory.rom.43.file	""
memory.rom.43.offset	0
mouse.sensitivityX	1
mouse.sensitivityY	1
sdext.enabled	No
sdext.imageFile	""
sdext.romFile	""
sid.3.model	0
sid.3.volumeL	1
sid.3.volumeR	1
sound.dcBlockFilter1Freq	10
sound.dcBlockFilter2Freq	10
sound.device	0
sound.enabled	Yes
sound.equalizer.frequency	1000
sound.equalizer.level	1
sound.equalizer.mode	-1
sound.equalizer.q	0.7071
sound.file	""
sound.highQuality	Yes
sound.hwPeriods	16
sound.latency	0.0700000001
sound.sampleRate	48000
sound.swPeriods	3
sound.volume	0.7071
tape.defaultSampleRate	24000
tape.enableSoundFileFilter	No
tape.forceMotorOn	No
tape.imageFile	""
tape.soundFileChannel	0
tape.soundFileFilterMaxFreq	5000
tape.soundFileFilterMinFreq	500
videoCapture.frameRate	50
videoCapture.yuvFormat	No
vm.cpuClockFrequency	4000000
vm.enableFileIO	Yes
vm.enableMemoryTimingEmulation	Yes
vm.processPriority	0
vm.soundClockFrequency	500000
vm.speedPercentage	100
vm.videoClockFrequency	889846


_EOF_
}