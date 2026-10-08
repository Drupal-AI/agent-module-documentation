#!/usr/bin/env bash
# Execution VERIFY: PASS when the LBR Move Node has its layout_onecol section moved to LAST,
# i.e. the final section is layout_onecol (and there are still 3 sections). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $nodes = \Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title"=>"LBR Move Node"]);
  $node = $nodes ? reset($nodes) : NULL;
  $ids = [];
  if ($node && $node->hasField("layout_builder__layout")) {
    foreach ($node->get("layout_builder__layout")->getSections() as $s) { $ids[] = $s->getLayoutId(); }
  }
  $ok = (count($ids) === 3 && end($ids) === "layout_onecol");
  print ($ok ? "PASS" : "FAIL") . " order=" . implode(",", $ids) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
