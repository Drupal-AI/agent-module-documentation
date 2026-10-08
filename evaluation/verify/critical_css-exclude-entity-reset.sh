#!/usr/bin/env bash
# hard RESET (critical_css): write critical_css.settings enabled with EMPTY excluded_ids so verify
# FAILS until entity id 7 is excluded. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("critical_css.settings")
    ->set("enabled", TRUE)
    ->set("dir_path", "/css/critical")
    ->set("excluded_ids", "")
    ->set("enabled_for_logged_in_users", FALSE)
    ->set("preload_non_critical_css", FALSE)
    ->save();
' >/dev/null 2>&1
echo "reset: critical_css.settings excluded_ids=(empty)"
