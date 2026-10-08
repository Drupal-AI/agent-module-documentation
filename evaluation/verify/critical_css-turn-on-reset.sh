#!/usr/bin/env bash
# hard RESET (critical_css): write critical_css.settings DISABLED with empty dir_path so verify
# FAILS until enabled with dir_path=/css/critical. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("critical_css.settings")
    ->set("enabled", FALSE)
    ->set("dir_path", "")
    ->set("excluded_ids", "")
    ->set("enabled_for_logged_in_users", FALSE)
    ->set("preload_non_critical_css", FALSE)
    ->save();
' >/dev/null 2>&1
echo "reset: critical_css.settings enabled=false dir_path=(empty)"
