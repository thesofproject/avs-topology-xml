Configuration files for the skylake sound driver
================================================

 * [Overview](#overview)
 * [Important](#important)
 * [Contributing](#contributing)

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

# Important

The skylake-driver as well as all its collaterals is **deprecated in favour of the
[avs-driver](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/sound/soc/intel/avs)**.
It's recommended for end users of newer Linux kernel version to switch to the latter solution. See
the main branch of this repository for information regarding topology files targeting the
avs-driver.

# Contributing

While the tool and its collaterals are shared mainly to help community deal with remaining problems
on the older configurations, any contributions are welcome.

Please see the chapter [Contributing](https://github.com/thesofproject/avs-topology-xml#contributing)
on the main branch for the guidelines.
