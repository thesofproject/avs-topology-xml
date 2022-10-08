Configuration files for Intel AudioVoiceSpeech (AVS) driver
========================

 * [Overview](#overview)
   * [DMIC](#dmic)
   * [HDAudio](#hdaudio)
   * [HDMI](#hdmi)
   * [I2S](#i2s)

# Overview

Each configuration file represents an audio stream topology i.e.: connections of AudioDSP pipelines
and processing modules that provide rich user experience with the Intel AVS stack. The avs-driver is
part of the Linux kernel sound subsystem,
[sound/soc/intel/avs](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/sound/soc/intel/avs).

Related to [alsa-topology-conf](https://github.com/alsa-project/alsa-topology-conf) yet instead of
UseCaseManagement (UCM) files, topologies found here are XML document files.

As the audio stack supports audio transfer over multiple interfaces, repository consists of
directories representing one interface each.

Kernel sound drivers are not capable of consuming topologies in their XML format. In order to obtain
kernel-friendly format, topology needs to be converted to UCM format first using
[avstplg](https://github.com/thesofproject/avsdk/tree/main/avstplg) tool and then finally to binary
using alsatplg, which is available by default on any Linux distribution.

Flow of conversion, from XML to bin:
```
	XML  ->  avstplg   ->  UCM
	UCM  ->  alsatplg  ->  bin
```
Result binaries are to be placed under `/lib/firmware/intel/avs` so they can be loaded by the
kernel.\
**Note:** the avs-driver loads only topologies for devices that have successfully enumerated during
system boot and are listed in supported configurations list found in:
[board_selection.c](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/sound/soc/intel/avs/board_selection.c)
file.

## DMIC

Digital Microphone support. Repository contains universal, multi-format topology that should work on
all Intel platforms equipped with AudioDSP, starting from Skylake onward.

## HDAudio

HDAudio codec expose anywhere between one to three uni or bidirectional endpoints:
Analog/Digital/Alt Analog. The actual number of supported endpoints and their description is
obtained during codec enumeration on the HDAudio bus.

Repository contains simple, generic reference for single-endpoint variant which should work for any
HDaudio configuration.

## HDMI

Follows the similar scheme as the [HDAudio](#hdaudio). The directory contains topology files
supporting Intel-devices only, that is HDAudio codecs that expose `0x8086` as their Vendor ID.
Another specific detail is that no capture streams are part of those topologies - all the HDMI
endpoints are unidirectional.

In general, given the PlatformControllerHub (PCH) generation, a HDMI device falls into: three, five
or nine -endpoint category. References for all of them are available.

## I2S

Least generic out of all available. Often a specific configuration is used per codec device. See
[sound/soc/intel/avs/boards](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/sound/soc/intel/avs/boards)
to check whether given configuration is supported by the kernel driver.
