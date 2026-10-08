#!/usr/bin/env bash
# Execution VERIFY: PASS when a content type "gtt_task" exists and is grouped in the Type Tray
# (which gin_type_tray themes) via its type_tray.type_category third-party setting being non-empty.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\node\Entity\NodeType;
  $t = NodeType::load("gtt_task");
  $cat = $t ? (string) $t->getThirdPartySetting("type_tray", "type_category", "") : "";
  $ok = ($t !== NULL && $cat !== "");
  print ($ok ? "PASS" : "FAIL") . " type=" . ($t ? "present" : "absent") . " type_category=" . var_export($cat, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
