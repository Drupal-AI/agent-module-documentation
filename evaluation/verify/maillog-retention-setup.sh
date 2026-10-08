#!/usr/bin/env bash
# Introspection SETUP: enable cron cleanup keeping the most recent 100 mail logs.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("maillog.settings")->set("cron_enabled", TRUE)->set("keep_limit_type", "number_to_keep")->set("number_to_keep", 100)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: maillog cron cleanup on, keep newest 100 entries"
