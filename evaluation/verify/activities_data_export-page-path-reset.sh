#!/usr/bin/env bash
# Execution RESET: force the activity_log 'page' display path back to the default
# admin/config/system/activity, so verify FAILS until the agent moves it. Raw config.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("views.view.activity_log");
  $d = $c->get("display");
  $d["page"]["display_options"]["path"] = "admin/config/system/activity";
  $c->set("display", $d)->save();
' >/dev/null 2>&1
echo "reset: activity_log page path = admin/config/system/activity (default)"
