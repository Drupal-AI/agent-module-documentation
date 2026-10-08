#!/usr/bin/env bash
# Restore shipped default 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("h5p.settings")->set("h5p_save_content_state",0)->save();' >/dev/null 2>&1
echo "cleanup: h5p.settings h5p_save_content_state=0 (default)"
