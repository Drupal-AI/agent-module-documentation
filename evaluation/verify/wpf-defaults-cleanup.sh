#!/usr/bin/env bash
# CLEANUP/baseline: restore Webp fallback shipped defaults (quality=75, styles.disabled=[]).
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("wpf.settings")
    ->set("quality", 75)->set("styles.disabled", [])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: wpf.settings quality=75, styles.disabled=[] (defaults)"
