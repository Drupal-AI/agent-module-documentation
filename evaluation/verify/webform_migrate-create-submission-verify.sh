#!/usr/bin/env bash
# Execution VERIFY: PASS when migrate_plus.migration webform_migrate_sub_task has source.plugin=d7_webform_submission and
# destination.plugin=entity:webform_submission. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $e = \Drupal::entityTypeManager()->getStorage("migration")->load("webform_migrate_sub_task");
  $ok = FALSE; $info = "missing";
  if ($e) {
    $sp = $e->get("source")["plugin"] ?? "";
    $dp = $e->get("destination")["plugin"] ?? "";
    $ok = ($sp === "d7_webform_submission" && $dp === "entity:webform_submission");
    $info = "source.plugin=" . var_export($sp, TRUE) . " destination.plugin=" . var_export($dp, TRUE);
  }
  print ($ok ? "PASS" : "FAIL") . " " . $info . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
