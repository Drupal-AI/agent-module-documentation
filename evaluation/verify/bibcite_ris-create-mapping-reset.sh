#!/usr/bin/env bash
# Execution RESET: ensure the ris mapping config (bibcite_entity.mapping.ris) does NOT exist, so verify FAILS until
# the agent creates it. Running reset again after the task = cleanup. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("bibcite_entity.mapping.ris")->delete();' >/dev/null 2>&1 || true
echo "reset: bibcite_entity.mapping.ris absent"
