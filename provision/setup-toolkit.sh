#!/bin/bash
# This file installs all needed plugins and theme(s)...and some dev dependencies.
# Author : Obi Merenu

set -e

REPO_GH='git@github.com:'
REPO_GH_HTTP='https://github.com'
REPO_GL='git@gitlab.com:'
WP_DIR='../public_html'
PLUGIN_DIR='../public_html/wp-content/plugins'
THEME_DIR='../public_html/wp-content/themes'
WP_P_URL='https://downloads.wordpress.org/plugin'
WP_T_URL='https://downloads.wordpress.org/theme'
WP_CONF='../public_html/wp-config.php'

list_items()
{
echo "
    THEMES:
    $(ls ${THEME_DIR})
 
    PLUGINS:
    $(ls ${PLUGIN_DIR})"
}

if [ ! -e ${WP_CONF} ]; then
    echo "Wrong directory"
    exit 1
else
    # install pseudo framework
    curl -LJO  ${REPO_GH_HTTP}'/Metumaribe/WordPress-Bare/archive/master.zip'
    unzip *.zip
    cp -a WordPress-Bare-master/. ${WP_DIR}
    rm -rf WordPress-Bare-master
    rm -rf *.zip
fi

# Arrange themes
if [ ! -d ${THEME_DIR}/timber-bootstrap ]; then
    # remove unused wp themes : keeps twentyseventeen
    if [ -d ${THEME_DIR}/twentyseventeen ]; then
        mv  -v  ${THEME_DIR}/twentyseventeen/ ${PLUGIN_DIR}
        rm -rf ${THEME_DIR}/*
        mv  -v  ${PLUGIN_DIR}/twentyseventeen/ ${THEME_DIR}
    fi
    # Install basic theme(s) for UI/UX tests
    git clone ${REPO_GH}Metumaribe/timber-bootstrap.git ${THEME_DIR}/timber-bootstrap
    cd ${THEME_DIR}
    curl -o ./shop-isle.1.1.35.zip ${WP_T_URL}'/shop-isle.1.1.35.zip'
    unzip *.zip
    #find ./ -name \*.zip -exec unzip {} \;
    rm -rf *.zip
fi
# install plugin dependencies.
if [ -d ${PLUGIN_DIR}/deals-wordpress-plugin ]; then
    echo "already setup"
    list_items
    exit 1
else
    # Clean up the plugins dir : removes the basic plugins.
    rm -rf ${PLUGIN_DIR}/*
    # Add base Plugin(s)
    git clone ${REPO_GL}owllabs/metumaribe-utility.git ${PLUGIN_DIR}/metumaribe-utility
    git clone ${REPO_GL}qasa/deals-wordpress-plugin.git ${PLUGIN_DIR}/deals-wordpress-plugin
    git clone ${REPO_GH}Metumaribe/easy-digital-downloads.git ${PLUGIN_DIR}/easy-digital-downloads
    git clone ${REPO_GH}Metumaribe/WordPress-Admin-Style.git ${PLUGIN_DIR}/WordPress-Admin-Style
    git clone ${REPO_GH}Metumaribe/wp-redis.git ${PLUGIN_DIR}/wp-redis
    # install debug files
    cd ${PLUGIN_DIR}
    curl -o ./rewrite-rules-inspector.1.2.1.zip ${WP_P_URL}'/rewrite-rules-inspector.1.2.1.zip'
    curl -o ./wp-crontrol.1.5.zip ${WP_P_URL}'/wp-crontrol.1.5.zip'
    curl -o ./transients-manager.zip ${WP_P_URL}'/transients-manager.zip'
    curl -o ./email-log.2.2.0.zip ${WP_P_URL}'/email-log.2.2.0.zip'
    curl -o ./query-monitor.2.15.0.zip ${WP_P_URL}'/query-monitor.2.15.0.zip'
    curl -o ./wordpress-mu-domain-mapping.0.5.5.1.zip ${WP_P_URL}'/wordpress-mu-domain-mapping.0.5.5.1.zip'
    curl -o ./multisite-clone-duplicator.1.4.1.zip ${WP_P_URL}'/multisite-clone-duplicator.1.4.1.zip'
    curl -o ./timber-library.zip ${WP_P_URL}'/timber-library.zip'
    # Unzip all files unzip *.zip
    find ./ -name \*.zip -exec unzip {} \;
    rm -rf *.zip
    rm -rf ${PLUGIN_DIR}/wp-crontrol/*
 fi

list_items
