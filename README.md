Configuration files for Intel AudioVoiceSpeech (AVS) driver
========================

 * [Overview](#overview)
   * [DMIC](#dmic)
   * [HDAudio](#hdaudio)
   * [HDMI](#hdmi)
   * [I2S](#i2s)
 * [Contributing](#contributing)
   * [Commit title](#commit-title)
     * [Scoping](#scoping)
   * [Commit message](#commit-message)
   * [Commit tags](#commit-tags)

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

# Contributing

While building a topology file requires some AudioDSP knowledge, especially in the driver <->
firmware interaction area, all contributions are welcome. Project follows submission guidelines
similar to those of high-profile projects, such as the Linux kernel.

## Commit title

Commit message title line length is limited to 72 characters.

### Scoping

Scoping shall be used to indicate the context of introduced changes, through adding subdirectory tag
('tag: ') at the beginning of commit's title. Leave the scope out only when submitting repo-wide
changes.

The scopes for subdirectories go as follows:
```
dmic/		dmic
hda/		hda
hdmi/		hdmi
i2s/		i2s
```

## Commit message

Regardless of type of change you want to submit, it must be described.
Please follow [Describe your changes](
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes) guide
for the best practises of doing so. The guide is quite lengthy, the essence is captured below:

*   State the motivation behind the change
*   Be transparent, do not hide things
*   Describe user impact if any
*   Use imperative mood
*   The lower level the problem is, the more detailed the description
    should be.
*   Ensure any links or references appended are actually working
*   Keep the line width with 72 characters margin

## Commit tags

[Sign your work](https://www.kernel.org/doc/html/latest/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin).

Optionally, at the bottom of commit message tags (kind of keywords) can be appended. These tags
serve informational purposes, further enhancing code documentation and enabling fixes propagation
through automated tasks. Below are guides for a range of such tags:

When to use [Acked-by:, Cc:, and Co-developed-by:](
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by)\
Using [Reported-by:, Tested-by:, Reviewed-by:, Suggested-by: and Fixes:](
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes)\
The final paragraphs of [Describe your changes](
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes) help
setup git config so appending correctly formatted **Fixes:** tag becomes trivial.
