#!/bin/bash

#
# setup.sh - Setup script for installing configs
# dotjrich
#

install_configuration()
{
    prog_name=$1
    repo_file=$2
    local_file=$3
    local_dir=`dirname $local_file`

    echo "[INFO] Preparing to install $prog_name configuration"

    if [[ ! -d $local_dir ]]; then
        echo "[INFO] Creating $prog_name configuration directory"
        mkdir -p $local_dir

        if [[ $? -ne 0 ]]; then
            echo "[ERROR] Failed to create $prog_name configuration directory"
            return
        fi
    fi
    
    if [[ -f $local_file ]]; then
        if [[ -h $local_file ]]; then
            if [[ `readlink $local_file` == $repo_file ]]; then
                echo "[INFO] Removing existing $prog_name installation"
                rm -f $local_file
            else
                echo "[ERROR] $prog_name configuration exists as symlink, but not pointing to repo directory... skipping install"
                return
            fi
        else
            echo "[ERROR] $prog_name configuration exists but is not a symlink... skipping install"
            return
        fi
    fi

    ln -s $repo_file $local_file
    if [[ $? -eq 0 ]]; then
        echo "[INFO] $prog_name configuration installed"
    else
        echo "[ERROR] Failed to install $prog_name configuration"
    fi
}

# Find repo directory.
pushd `dirname $0` > /dev/null
REPO_DIR=`pwd`
popd > /dev/null
echo "[INFO] Found repo directory: $REPO_DIR"

install_configuration Vim $REPO_DIR/vim/.vimrc $HOME/.vimrc
install_configuration Emacs $REPO_DIR/emacs/init.el $HOME/.emacs.d/init.el
