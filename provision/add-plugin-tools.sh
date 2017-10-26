#!/bin/bash
# This file loads all needed plugins and theme(s).
# Author : Obi Merenu

REPO_GH='git@github.com:'
PLUGIN_DIR='../public_html/wp-content/plugins'
THEME_DIR='../public_html/wp-content/themes'
WP_URL='https://downloads.wordpress.org/plugin'


if [ -d ${PLUGIN_DIR} ]; then
    # delete submodules first @todo add a check for presence of submodules
    # deinit all submodules from .gitmodules

    # Delete the plugins
    rm -rf ${PLUGIN_DIR}/*

    # Add base Theme
    git clone ${REPO_GH}Metumaribe/timber-bootstrap.git ${THEME_DIR}/timber-bootstrap
    # Add base Plugins
    git clone ${REPO_GH}Metumaribe/easy-digital-downloads.git ${PLUGIN_DIR}/easy-digital-downloads
    git clone ${REPO_GH}Metumaribe/WordPress-Admin-Style.git ${PLUGIN_DIR}/WordPress-Admin-Style
    git clone ${REPO_GH}Metumaribe/wp-redis.git ${PLUGIN_DIR}/wp-redis

else
    echo "${PLUGIN_DIR} doesn't exists"
fi

# Install from WordPress.org
cd ${PLUGIN_DIR}

file_out=$(curl -o ./timber-library.zip ${WP_URL}'/timber-library.zip' 2>&1)

if [[ $? -eq 0 && ${file_out} ]]; then
 # install debug files
 curl -o ./rewrite-rules-inspector.1.2.1.zip ${WP_URL}'/rewrite-rules-inspector.1.2.1.zip'
 curl -o ./wp-crontrol.1.5.zip ${WP_URL}'/wp-crontrol.1.5.zip'
 curl -o ./transients-manager.zip ${WP_URL}'/transients-manager.zip'
 curl -o ./email-log.2.2.0.zip ${WP_URL}'/email-log.2.2.0.zip'
 curl -o ./query-monitor.2.15.0.zip ${WP_URL}'/query-monitor.2.15.0.zip'

 # Unzip all files
 # unzip *.zip
 find ./ -name \*.zip -exec unzip {} \;
 rm -rf *.zip
 ls -al

 rm -rf ${PLUGIN_DIR}/wp-crontrol/*
fi
