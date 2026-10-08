#!/usr/bin/env bash
# Restore shipped default 'h5p'.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("h5p.settings")->set("h5p_default_path","h5p")->save();' >/dev/null 2>&1
echo "cleanup: h5p.settings h5p_default_path=h5p (default)"
