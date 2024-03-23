#!/bin/bash

if [[ "$1" =~ "dev" ]]; then
    POSTCOPY_CLONE=$(echo $1 | sed 's/.*dev/dev/g')
else
    POSTCOPY_CLONE=$1
fi

pacman-key --init 
pacman --noconfirm -Syu btrfs-progs archiso git reflector 
git clone https://github.com/holoiso-staging/buildroot buildroot 
git clone https://github.com/holoiso-staging/postcopy -b ${POSTCOPY_CLONE} buildroot/postcopy_$1 
mkdir -p $(pwd)/output $(pwd)/workdir 
bash buildroot/build.sh --flavor $1 --deployment_rel $1 --snapshot_ver "${GITHUB_REF_NAME}" --workdir $(pwd)/workdir --output-dir $(pwd)/output/holoiso-images --add-release