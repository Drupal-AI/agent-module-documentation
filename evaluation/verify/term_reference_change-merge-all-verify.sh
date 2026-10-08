#!/usr/bin/env bash
# Execution VERIFY: PASS when all three TRC Merge articles reference the "New Topic" term
# in field_trc_merge and none of them still references "Old Topic".
# Prints PASS/FAIL; exit 0 = pass, 1 = fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $ts = \Drupal::entityTypeManager()->getStorage("taxonomy_term");
  $old = $ts->loadByProperties(["vid" => "trc_merge", "name" => "Old Topic"]);
  $new = $ts->loadByProperties(["vid" => "trc_merge", "name" => "New Topic"]);
  $old = $old ? reset($old)->id() : NULL;
  $new = $new ? reset($new)->id() : NULL;
  $ok = ($new !== NULL);
  $report = [];
  $storage = \Drupal::entityTypeManager()->getStorage("node");
  foreach (["TRC Merge A", "TRC Merge B", "TRC Merge C"] as $title) {
    $found = $storage->loadByProperties(["title" => $title]);
    if (!$found) { $ok = FALSE; $report[] = "$title=missing"; continue; }
    $n = reset($found);
    $ids = array_column($n->get("field_trc_merge")->getValue(), "target_id");
    $report[] = $title . "=[" . implode("|", $ids) . "]";
    if (!in_array($new, $ids)) { $ok = FALSE; }
    if ($old !== NULL && in_array($old, $ids)) { $ok = FALSE; }
  }
  print ($ok ? "PASS" : "FAIL") . " old=" . var_export($old, TRUE) . " new=" . var_export($new, TRUE) . " " . implode(" ", $report) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
