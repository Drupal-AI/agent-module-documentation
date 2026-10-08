#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# Introspection setup for "does olivero_fixes load?" — force the site's front-end
# (default) theme to Olivero so the active theme chain contains `olivero`. The agent
# must read system.theme:default off the live site to answer that the module attaches
# media_library_theme_reset/olivero_fixes on the front-end media library add form.
set -uo pipefail
cd /var/www/html
drush config:set system.theme default olivero -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: default (front-end) theme set to olivero"
