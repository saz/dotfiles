#!/bin/bash

function linkFile {
    source="${PWD}/$1"
    target="${HOME}/${1/_/.}"

    # Only create backup if target is a file or directory
    if [ -f "${target}" ] || [ -d "${target}" ]; then
        mv "$target" "$target.bak"
    fi

    ln -sf "${source}" "${target}"
}

for i in _*
do
    if [ "$i" == "_config" ]; then
        for j in $i/*
        do
            linkFile "$j" "$j"
        done
    else
        linkFile "$i"
    fi
done

# Only run git commands, if we're using any submodules
git submodule sync
git submodule init
git submodule update
git submodule foreach git pull origin master
git submodule foreach git submodule init
git submodule foreach git submodule update

# Awesome and Obvious specific stuff
awesome_version=`awesome -v|grep awesome|cut -d' ' -f2`
cd ${HOME}/.config/awesome/obvious
git checkout $awesome_version > /dev/null 2>&1
if [ $? -eq 1 ]; then
    git checkout v3.4.10
fi
cd -
