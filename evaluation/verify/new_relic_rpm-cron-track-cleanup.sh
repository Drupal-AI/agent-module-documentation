#!/usr/bin/env bash
# Introspection CLEANUP: restore shipped default track_cron=norm. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("new_relic_rpm.settings")->set("track_cron", "norm")->save();
' >/dev/null 2>&1
echo "cleanup: new_relic_rpm.settings track_cron restored to norm"
