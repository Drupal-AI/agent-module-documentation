#!/usr/bin/env bash
# Execution RESET: clear the additional allowed-forms list so verify fails until the agent adds it.
set -uo pipefail
cd /var/www/html
drush cset readonlymode.settings forms.additional.edit '' -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: readonlymode forms.additional.edit=''"
