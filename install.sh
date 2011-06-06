#!/bin/bash

function linkFile {
    source="${PWD}/$1"
    target="${HOME}/${1/_/.}"

    # Only create backup if target is a file or directory
    if [ -f "${target}" ] || [ -d "${target}" ]; then
        mv $target $target.bak
    fi

    ln -sf ${source} ${target}
}

for i in _*
do
    if [ "$i" == "_config" ]; then
        for j in $i/*
        do
            linkFile "$j" "$j"
        done
    else
        linkFile $i
    fi
done

# Only run git commands, if we're using any submodules
git submodule sync
git submodule init
git submodule update
git submodule foreach git pull origin master
git submodule foreach git submodule init
git submodule foreach git submodule update
