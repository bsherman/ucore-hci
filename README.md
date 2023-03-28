# ucore-hci

[![build-ucore](https://github.com/bsherman/ucore-hci/actions/workflows/build.yml/badge.svg)](https://github.com/bsherman/ucore-hci/actions/workflows/build.yml)


## What is this?

This is an OCI image of [ucore-os/ucore](https://github.com/ublue-os/ucore) ([Fedora CoreOS](https://getfedora.org/coreos/)) customized for use as HCI (hyper-converged infrastructure) host with livirtd and ZFS.

### WARNING: not yet tested

## Features

- Start with [ublue-os/ucore](https://github.com/ublue-os/ucore) as a base and get all its goodness
- add some packages:
  - ZFS built via [ucore-kmods](https://github.com/bsherman/ucore-kmods)
  - libvirtd (to host virtual machines)
  - cockpit-machines (to manage virtual machines)
  - [cockpit-zfs-manager](https://github.com/45Drives/cockpit-zfs-manager) (to manage ZFS storage)


This image should be suitable for use on bare metal or in a virtual machines where you wish to run containerized workloads, host virtual machines, or use ZFS. It uses significantly more disk space than [ucore-main](https://github.com/bsherman/ucore-main), so check that out if you don't need to host VMs or use  ZFS.

One can also layer packages directly on a machine running this or use this image as a base for a further customized OCI.

## Usage

To rebase an Fedora CoreOS machine to the latest release (stable):

    sudo rpm-ostree rebase ostree-unverified-registry:ghcr.io/bsherman/ucore-hci:stable

  
## Verification

These images are signed with sisgstore's [cosign](https://docs.sigstore.dev/cosign/overview/). You can verify the signature by downloading the `cosign.pub` key from this repo and running the following command:

    cosign verify --key cosign.pub ghcr.io/bsherman/ucore-hci