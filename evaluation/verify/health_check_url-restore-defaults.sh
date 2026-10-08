#!/usr/bin/env bash
# Shared CLEANUP/RESET (health_check_url): restore shipped defaults
# (type=timestamp, string=Passed, endpoint=/health, maintainence_access=false). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("health_check_url.settings")
    ->set("type", "timestamp")->set("string", "Passed")
    ->set("endpoint", "/health")->set("maintainence_access", FALSE)->save();
' >/dev/null 2>&1 || true
echo "restore: health_check_url.settings back to shipped defaults (/health, Passed, timestamp)"
exit 0
