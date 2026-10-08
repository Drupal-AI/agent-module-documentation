#!/usr/bin/env bash
# Introspection CLEANUP: restore baseline (empty defaults map). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("form_mode_control.settings")->set("defaults", [])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: form_mode_control.settings defaults reset to {}"
