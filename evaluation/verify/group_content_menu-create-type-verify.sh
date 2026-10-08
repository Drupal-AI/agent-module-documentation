#!/usr/bin/env bash
# Execution VERIFY: PASS when group_content_menu_type gcm_task exists with label 'Task Menu'.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\group_content_menu\Entity\GroupContentMenuType;
  $t = GroupContentMenuType::load("gcm_task");
  $ok = ($t && $t->label() === "Task Menu");
  print ($ok ? "PASS" : "FAIL") . " gcm_task=" . ($t ? "exists" : "missing") . " label=" . var_export($t ? $t->label() : NULL, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
