#!/usr/bin/env bash
# MEDIUM cleanup: remove the md_reviewer role created by the setup script.
# SPDX-License-Identifier: GPL-2.0-or-later
set -uo pipefail
cd /var/www/html
drush role:delete md_reviewer >/dev/null 2>&1 || true
drush cr >/dev/null 2>&1
echo "cleanup: role md_reviewer deleted"
