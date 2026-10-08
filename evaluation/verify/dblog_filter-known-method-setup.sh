#!/usr/bin/env bash
# Introspection SETUP: configure dblog_filter to log ONLY error-and-above to the database log
# (method=include, error/critical/alert/emergency checked) so an agent can read the policy back.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("dblog_filter.settings");
  $c->set("method", "include")->set("severity_levels", [
    "emergency"=>true,"alert"=>true,"critical"=>true,"error"=>true,
    "warning"=>false,"notice"=>false,"info"=>false,"debug"=>false,
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: dblog_filter method=include, severities error/critical/alert/emergency=true"
