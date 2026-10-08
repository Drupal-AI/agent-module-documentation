#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  $db = \Drupal::database();
  if ($db->schema()->tableExists("config_log")) {
    $db->delete("config_log")->condition("name", "clv_eval_marker.settings")->execute();
  }
' >/dev/null 2>&1
echo "cleanup: clv_eval_marker.settings row removed"
