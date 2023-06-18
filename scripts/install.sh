#!/usr/bin/env bash

NAME="Ve"
EXIT_ABNORMAL=2
NVIM_COMMAND="nvim"
MIN_NVIM_VERSION="0.8"
PACKER_URL="https://github.com/wbthomason/packer.nvim"
SELF_URL="https://github.com/wenijinew/nvim-config.git"

function _warn(){
    echo -e "\033[35mWARNING:\033[0m ${1}"
}

function nvim_version(){
    nvim --version | head -1 | grep -Eo '([0-9].?)+'
}

function check_neovim_min_version() {
    if ! command -v $NVIM_COMMAND &>/dev/null; then
        _warn "Cannot find executable '${NVIM_COMMAND}' in PATH."
        exit $EXIT_ABNORMAL
    fi
    version=$(nvim_version)
    if [ "${version}" \< "${MIN_NVIM_VERSION}" ];then
        _warn "${NAME} requires at least ${MIN_NVIM_VERSION} or higher"
        exit $EXIT_ABNORMAL
    fi
}

function clone_repo(){
    target_path="${1}"
    repo_url="${2}"
    if [ ! -e ${target_path} ];then
        mkdir -p ${target_path}
        git clone --depth 1 ${repo_url} ${target_path}
    fi
}

function clone_packer(){
    target_path="~/.local/share/nvim/site/pack/packer/start/packer.nvim"
    clone_repo "${target_path}" "${PACKER_URL}"
}

function clone_self(){
    clone_repo "~/.config/nvim" "${SELF_URL}"
}

function install_plugins(){
    packer_install_cmd="PackerInstall"
    "${NVIM_COMMAND}" -c "${packer_install_cmd}" -c "quit" --headless
}

function install(){
    check_neovim_min_version
    clone_packer
    clone_self
    install_plugins
}


install
