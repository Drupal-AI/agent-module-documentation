#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# Restore the baseline: default (front-end) theme = olivero (the site default).
set -uo pipefail
cd /var/www/html
drush config:set system.theme default olivero -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: default theme restored to olivero"
