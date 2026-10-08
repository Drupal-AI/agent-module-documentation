#!/usr/bin/env bash
# Execution RESET: clear allowed_image_styles in acquia_dam.settings (no restriction set) so
# verify FAILS until the agent restricts it. Local config only. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("acquia_dam.settings")->clear("allowed_image_styles")->save();' >/dev/null 2>&1
echo "reset: acquia_dam.settings allowed_image_styles=[]"
