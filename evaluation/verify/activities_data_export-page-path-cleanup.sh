#!/usr/bin/env bash
# Execution CLEANUP: restore the default activity_log page path. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("views.view.activity_log");
  $d = $c->get("display");
  $d["page"]["display_options"]["path"] = "admin/config/system/activity";
  $c->set("display", $d)->save();
' >/dev/null 2>&1
echo "cleanup: activity_log page path restored to admin/config/system/activity"
