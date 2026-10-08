#!/usr/bin/env bash
# medium SETUP (critical_css): write critical_css.settings with a known dir_path. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("critical_css.settings")
    ->set("enabled", TRUE)
    ->set("dir_path", "/css/ccss-known")
    ->set("excluded_ids", "")
    ->set("enabled_for_logged_in_users", FALSE)
    ->set("preload_non_critical_css", FALSE)
    ->save();
' >/dev/null 2>&1
echo "setup: critical_css.settings dir_path=/css/ccss-known"
