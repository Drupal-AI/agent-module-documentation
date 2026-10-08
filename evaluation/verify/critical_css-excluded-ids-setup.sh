#!/usr/bin/env bash
# medium SETUP (critical_css): write critical_css.settings excluding entity ids 42 and 99. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("critical_css.settings")
    ->set("enabled", TRUE)
    ->set("dir_path", "/css/critical")
    ->set("excluded_ids", "42\n99")
    ->set("enabled_for_logged_in_users", FALSE)
    ->set("preload_non_critical_css", FALSE)
    ->save();
' >/dev/null 2>&1
echo "setup: critical_css.settings excluded_ids=42,99"
