#!/usr/bin/env bash
# Execution VERIFY: PASS when a view with id history_unread exists, is over the node_field_data
# base table, and uses the history module's history_user_timestamp filter on the {history}
# table. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::entityTypeManager()->getStorage("view")->load("history_unread");
  if (!$v) { print "FAIL view-missing\n"; return; }
  $base = $v->get("base_table");
  $found = FALSE;
  foreach ($v->get("display") as $display) {
    foreach (($display["display_options"]["filters"] ?? []) as $filter) {
      $plugin = $filter["plugin_id"] ?? ($filter["id"] ?? "");
      $table = $filter["table"] ?? "";
      if ($plugin === "history_user_timestamp" && $table === "history") { $found = TRUE; }
    }
  }
  $ok = $found && ($base === "node_field_data");
  print ($ok ? "PASS" : "FAIL") . " base_table=" . var_export($base, TRUE) . " history_filter=" . var_export($found, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
