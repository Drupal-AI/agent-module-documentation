#!/usr/bin/env bash
# Execution RESET: ensure the endnote7 mapping config (bibcite_entity.mapping.endnote7) does NOT exist, so verify FAILS until
# the agent creates it. Running reset again after the task = cleanup. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("bibcite_entity.mapping.endnote7")->delete();' >/dev/null 2>&1 || true
echo "reset: bibcite_entity.mapping.endnote7 absent"
