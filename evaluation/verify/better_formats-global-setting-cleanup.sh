#!/usr/bin/env bash
# Restore shipped default per_field_core=FALSE. Idempotent. Exit 0. (also used as hard reset/cleanup)
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("better_formats.settings")->set("per_field_core", FALSE)->save();' >/dev/null 2>&1
echo "baseline: better_formats.settings per_field_core=FALSE"
