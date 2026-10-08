#!/usr/bin/env bash
# MEDIUM introspection cleanup: restore system.site mail to its baseline.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("system.site")->set("mail", "admin@example.com")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: system.site mail restored to baseline (admin@example.com)"
