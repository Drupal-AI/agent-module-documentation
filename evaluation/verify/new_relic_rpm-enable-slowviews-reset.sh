#!/usr/bin/env bash
# Execution RESET: force slow-views logging OFF and threshold back to 100 so verify FAILS
# until the agent enables it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("new_relic_rpm.settings");
  $c->set("views_log_slow", FALSE)->set("views_log_threshold", 100)->save();
' >/dev/null 2>&1
echo "reset: views_log_slow=false views_log_threshold=100"
