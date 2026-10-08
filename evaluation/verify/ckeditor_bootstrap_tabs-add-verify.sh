#!/usr/bin/env bash
# Execution VERIFY: PASS when the ckbt_task CKEditor 5 toolbar includes the bootstrapTabs button.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\editor\Entity\Editor;
  $e = Editor::load("ckbt_task");
  $items = $e ? ($e->getSettings()["toolbar"]["items"] ?? []) : [];
  $ok = in_array("bootstrapTabs", $items, TRUE);
  print ($ok ? "PASS" : "FAIL") . " items=" . json_encode($items) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
