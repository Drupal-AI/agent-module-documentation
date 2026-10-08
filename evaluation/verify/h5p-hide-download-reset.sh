#!/usr/bin/env bash
# Execution RESET/CLEANUP: restore h5p_export to shipped default (3) so verify FAILS until agent
# sets 0. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("h5p.settings")->set("h5p_export",3)->save();' >/dev/null 2>&1
echo "reset: h5p.settings h5p_export=3 (default)"
