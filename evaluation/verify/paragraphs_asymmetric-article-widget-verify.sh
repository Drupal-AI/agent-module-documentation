#!/usr/bin/env bash
# Live-state verification (hard tier) for the "set the Article paragraphs field to this
# module's asymmetric widget" task. Prints PASS/FAIL with detail; exits 0 (pass) / 1 (fail).
# PASS only if the node.article.default entity_FORM_display has a component for
# field_asym_para whose widget type is `paragraphs_classic_asymmetric` (the id this module
# registers). No arguments.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $fd = \Drupal::service("entity_display.repository")->getFormDisplay("node", "article", "default");
  $c = $fd ? $fd->getComponent("field_asym_para") : NULL;
  $exists = is_array($c);
  $type = ($exists && isset($c["type"])) ? $c["type"] : "";
  $ok = $type === "paragraphs_classic_asymmetric";
  print ($ok ? "PASS" : "FAIL")
    . " component=" . ($exists?1:0)
    . " widget=" . ($type!==""?$type:"-") . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
