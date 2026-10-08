#!/usr/bin/env bash
# Execution VERIFY: PASS when the LBR Task Node layout sections have been reordered so the FIRST
# section is layout_twocol_section and the second is layout_onecol. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $nodes = \Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title"=>"LBR Task Node"]);
  $node = $nodes ? reset($nodes) : NULL;
  $ids = [];
  if ($node && $node->hasField("layout_builder__layout")) {
    foreach ($node->get("layout_builder__layout")->getSections() as $s) { $ids[] = $s->getLayoutId(); }
  }
  $ok = (($ids[0] ?? "") === "layout_twocol_section" && ($ids[1] ?? "") === "layout_onecol");
  print ($ok ? "PASS" : "FAIL") . " order=" . implode(",", $ids) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
