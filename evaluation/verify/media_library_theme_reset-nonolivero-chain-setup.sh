#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# Introspection setup for the negative case — force the site's front-end (default)
# theme to Claro, which has NO Olivero in its base-theme chain. The agent must read
# system.theme:default off the live site and conclude that on this front-end theme the
# module attaches only its base library (media-library-fixes.css) and does NOT attach
# media_library_theme_reset/olivero_fixes.
set -uo pipefail
cd /var/www/html
drush config:set system.theme default claro -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: default (front-end) theme set to claro (no olivero in chain)"
