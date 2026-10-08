#!/usr/bin/env bash
# Execution RESET: force Material Icons families back to the shipped default (['baseline']) so
# verify (which expects outlined + sharp) FAILS until the agent enables them. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("material_icons.settings")->set("families", ["baseline"])->save();' >/dev/null 2>&1
echo "reset: material_icons.settings families=[baseline]"
