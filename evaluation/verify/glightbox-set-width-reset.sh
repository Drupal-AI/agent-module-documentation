#!/usr/bin/env bash
# Execution RESET: set glightbox width back to default 98% so verify FAILS until the agent sets 75%.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("glightbox.settings")->set("custom.width","98%")->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: glightbox.settings custom.width=98%"
