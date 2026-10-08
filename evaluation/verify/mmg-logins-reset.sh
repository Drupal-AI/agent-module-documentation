#!/usr/bin/env bash
# Execution RESET: ensure monitoring_multigraph enabled and NO multigraph contains user_failed_logins
# (verify FAILS until agent builds one). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pm:install monitoring_multigraph -y >/dev/null 2>&1
drush php:eval '
  use Drupal\monitoring_multigraph\Entity\Multigraph;
  foreach (Multigraph::loadMultiple() as $m) {
    $s = $m->get("sensors") ?? [];
    if (array_key_exists("user_failed_logins", $s)) { $m->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: monitoring_multigraph enabled; no multigraph contains user_failed_logins"
