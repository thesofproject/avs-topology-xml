Configuration files for the skylake sound driver
================================================

 * [Important](#important)
 * [Overview](#overview)
   * [Supported configurations](#supported-configurations)
 * [Contributing](#contributing)

# Important

The skylake-driver as well as all its collaterals is **deprecated in favour of the
[avs-driver](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/sound/soc/intel/avs)**.
It's recommended for end users of newer Linux kernel version to switch to the latter solution. See
the main branch of this repository for information regarding topology files targeting the
avs-driver.

# Overview

Each configuration file represents an audio stream topology i.e.: connections of AudioDSP pipelines
and processing modules that provide rich user experience with the Intel audio stack. The files are
intended for use with the [itt](https://github.com/thesofproject/avsdk/tree/for-skylake-driver) tool
and the
[skylake-driver](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/sound/soc/intel/skylake)
that is part of the Linux kernel.

[alsa-topology-conf](https://github.com/alsa-project/alsa-topology-conf) also hosts topology files
but in alsa-lib friendly format i.e.: UseCaseManagement (UCM). Topologies found here are written in
widely adopted XML.

Kernel sound drivers are not capable of consuming topologies in their XML format. In order to obtain
kernel-friendly format, topology needs to be converted to UCM format first using the mentioned itt
tool and then finally to binary using [alsatplg](https://github.com/alsa-project/alsa-utils), which
is available by default on any Linux distribution.

Flow of conversion, from XML to bin:
```
	XML  ->  itt       ->  UCM
	UCM  ->  alsatplg  ->  bin
```
Result binaries are to be placed under `/lib/firmware/intel` so they can be loaded by the kernel.\
**Note:** the skylake-driver loads only topologies for devices that have successfully enumerated
during system boot and are listed in supported configurations list found in:
[sound/soc/intel/common](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/sound/soc/intel/common)
directory.

Connected to:
[enable HDAudio+DMIC with skylake-driver](https://gist.github.com/crojewsk/4e6382bfb0dbfaaf60513174211f29cb)
guide.

## Supported configurations

Table below lists all configurations supported by the skylake-driver starting from its internal
release for kernel v4.4 when its topologies followed different format (IDs: 0065, 0071). Designs
with EOL at v4.19 or earlier were left with the old topology format. Starting from v5.4, newer
revision (ID: 0072) is used.

Code for all of the boards can be found in `sound/soc/intel/boards/` directory of the Linux kernel.
Names in the left column match platform driver's name, not the name of actual C file.

| Name			| Upgraded	| Targets	| Comments
| ---			| ---		| ---		| ---
| skl_hda_dsp_generic	| Yes		| All HDAudio	|
| skl_alc286s_i2s	| Yes		| RVP		|
| skl_n88l25_s4567	| No		| Chell		|
| skl_n88l25_m98357a	| No		| Lars		|
| kbl_alc286s_i2s	| Yes		| RVP		| Namesake of skl_alc286s_i2s
| kbl_n88l25_s4567	| No		| Unknown	| Namesake of skl_n88125_s4567
| kbl_n88l25_m98357a	| No		| Unknown	| Namesake of skl_n88125_m98357a
| kbl_r5514_5663_max	| Yes		| Eve		|
| kbl_rt5663_m98927	| Yes		| Soraka	|
| kbl_rt5663		| No		| Unknown	| Variation of kbl_rt5663_m98927
| kbl_da7219_mx98357a	| Yes		| Nami, Nautilus|
| kbl_da7219_max98927	| No		| Unknown	|
| kbl_rt5660		| No		| Unknown	| Added by Cannonical
| kbl_da7219_max98373	| Yes		| Atlas		| Variation of kbl_da7219_max98927
| kbl_max98373		| Yes		| Nocturne	| Variation of kbl_da7219_max98927
| bxt_alc298s_i2s	| Yes		| RVP		|
| bxt_da7219_mx98357a	| No		| Snappy, Coral	|
| bxt_tdf8532		| Yes		| RVP		| Driver never provided to upstream
| glk_alc298s_i2s	| Yes		| RVP		| Variation of bxt_alc298s_i2s
| glk_da7219_mx98357a	| No		| Yorp		| Variation of bxt_da7219_max98357a
| cnl_rt274		| Yes		| RVP		| Driver never provided to upstream
| icl_rt274		| Yes		| RVP		| Driver never provided to upstream

# Contributing

While the tool and its collaterals are shared mainly to help community deal with remaining problems
on the older configurations, any contributions are welcome.

Please see the chapter [Contributing](https://github.com/thesofproject/avs-topology-xml#contributing)
on the main branch for the guidelines.
