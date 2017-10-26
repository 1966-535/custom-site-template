#!/bin/bash
# This file installs all needed plugins and theme(s)...and some dev dependencies.
# Author : Obi Merenu

REPO_GH='git@github.com:'
REPO_GL='git@gitlab.com:'
WP_DIR='../public_html'
PLUGIN_DIR='../public_html/wp-content/plugins'
THEME_DIR='../public_html/wp-content/themes'
WP_URL='https://downloads.wordpress.org/plugin'

# check if its the wordpress dir : @todo concatenate wp-config.php to $WP_DIR.
if [ -d ${WP_DIR} ]; then

    # Clean up the plugins dir : removes the basic plugins that i don't use.
    rm -rf ${PLUGIN_DIR}/*

    # Add base Theme
    git clone ${REPO_GH}Metumaribe/timber-bootstrap.git ${THEME_DIR}/timber-bootstrap
    # Add base Plugins
    git clone ${REPO_GL}owllabs/metumaribe-utility.git ${PLUGIN_DIR}/metumaribe-utility
    git clone ${REPO_GL}qasa/deals-wordpress-plugin.git ${PLUGIN_DIR}/deals-wordpress-plugin
    git clone ${REPO_GH}Metumaribe/easy-digital-downloads.git ${PLUGIN_DIR}/easy-digital-downloads
    git clone ${REPO_GH}Metumaribe/WordPress-Admin-Style.git ${PLUGIN_DIR}/WordPress-Admin-Style
    git clone ${REPO_GH}Metumaribe/wp-redis.git ${PLUGIN_DIR}/wp-redis

else
    echo "${PLUGIN_DIR} doesn't exists"
fi


# move the test files into the rootl
# ${WP_DIR}/wp-tests


# Install plugins from WordPress.org
cd ${PLUGIN_DIR}

file_out=$(curl -o ./timber-library.zip ${WP_URL}'/timber-library.zip' 2>&1)

if [[ $? -eq 0 && ${file_out} ]]; then
 # install debug files
 curl -o ./rewrite-rules-inspector.1.2.1.zip ${WP_URL}'/rewrite-rules-inspector.1.2.1.zip'
 curl -o ./wp-crontrol.1.5.zip ${WP_URL}'/wp-crontrol.1.5.zip'
 curl -o ./transients-manager.zip ${WP_URL}'/transients-manager.zip'
 curl -o ./email-log.2.2.0.zip ${WP_URL}'/email-log.2.2.0.zip'
 curl -o ./query-monitor.2.15.0.zip ${WP_URL}'/query-monitor.2.15.0.zip'
 curl -o ./wordpress-mu-domain-mapping.0.5.5.1.zip ${WP_URL}'/wordpress-mu-domain-mapping.0.5.5.1.zip'
 curl -o ./multisite-clone-duplicator.1.4.1.zip ${WP_URL}'/multisite-clone-duplicator.1.4.1.zip'

 # Unzip all files
 # unzip *.zip
 find ./ -name \*.zip -exec unzip {} \;
 rm -rf *.zip
 ls -al

 rm -rf ${PLUGIN_DIR}/wp-crontrol/*
fi
