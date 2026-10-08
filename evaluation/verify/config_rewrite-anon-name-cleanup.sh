#!/usr/bin/env bash
# MEDIUM introspection cleanup: restore user.settings anonymous name to its baseline.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("user.settings")->set("anonymous", "Anonymous")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: user.settings anonymous restored to baseline (Anonymous)"
