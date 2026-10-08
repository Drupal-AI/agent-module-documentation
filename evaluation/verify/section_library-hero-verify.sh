#!/usr/bin/env bash
# Live-state verification for the "Homepage Hero" hard case. Prints PASS/FAIL with detail
# and exits 0 (pass) / 1 (fail). No arguments.
# Requires a section_library_template to exist with:
#   label = "Homepage Hero", type = "template",
#   at least one layout_section section whose first section layout id is "layout_onecol".
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("section_library_template");
  $ok = FALSE; $type = ""; $layout = ""; $count = 0;
  $ids = $storage->getQuery()->accessCheck(FALSE)->condition("label", "Homepage Hero")->execute();
  foreach ($storage->loadMultiple($ids) as $t) {
    $type = $t->get("type")->value;
    $items = $t->get("layout_section");
    $count = count($items->getValue());
    $first = $items->first();
    $layout = ($first && $first->section) ? $first->section->getLayoutId() : "";
    if ($type === "template" && $count >= 1 && $layout === "layout_onecol") { $ok = TRUE; }
  }
  print ($ok ? "PASS" : "FAIL") . " type=" . $type . " count=" . $count . " layout=" . $layout . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
