#!/bin/bash

function linkFile {
    sleep 1
    src="${PWD}/$1"
    target="${HOME}/${1/_/.}"
    backup="${target}.bak"

    # Remove any previous backup.
    if [ -e "${backup}" ]; then
        if [ -f "${backup}" ] || [ -h "${backup}" ]; then
            rm "${backup}"
        elif [ -d "${backup}" ]; then
            rm -r "${backup}"
        fi
    fi

    # Only create backup if target is a file or directory
    if [ -f "${target}" ] || [ -d "${target}" ]; then
        mv "$target" "$target.bak"
    fi

    ln -sf "${src}" "${target}"
}

for i in _*
do
    if [ "$i" == "_config" ]; then
        if [ ! -d "${HOME}/.config" ]; then
            mkdir "${HOME}/.config"
        fi

        for j in $i/*
        do
            linkFile "$j"
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

## Awesome and Obvious specific stuff
#if [ -x "/usr/bin/awesome" ]; then
#    awesome_version=`awesome -v|grep awesome|cut -d' ' -f2`
#    cd ${HOME}/.config/awesome/obvious
#    git checkout $awesome_version > /dev/null 2>&1
#    if [ $? -eq 1 ]; then
#        git checkout v3.4.10
#    fi
#fi

if [ -n "${OLDPWD}" ]; then
    cd -
fi
