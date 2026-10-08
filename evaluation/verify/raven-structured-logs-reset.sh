#!/usr/bin/env bash
# HARD execution reset: disable Sentry structured logs and clear all logs_log_levels,
# so the case starts from a known-empty state.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("raven.settings")
    ->set("enable_logs", FALSE)
    ->set("logs_log_levels", ["emergency" => FALSE, "alert" => FALSE, "critical" => FALSE, "error" => FALSE, "warning" => FALSE, "notice" => FALSE, "info" => FALSE, "debug" => FALSE])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: enable_logs=false, logs_log_levels all false"
