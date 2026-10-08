#!/usr/bin/env bash
# hard VERIFY (module_missing_message_fixer): PASS when the mmmf_task system.schema entry is gone. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::keyValue("system.schema")->get("mmmf_task");
  $ok = ($v === NULL);
  print ($ok ? "PASS" : "FAIL") . " mmmf_task=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
