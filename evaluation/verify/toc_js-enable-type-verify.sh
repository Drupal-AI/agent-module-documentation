#!/usr/bin/env bash
# Execution VERIFY: PASS when content type tocjs_page has toc_js.toc_js_active===TRUE AND its default
# view display has the toc_js extra field placed. Exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\node\Entity\NodeType;
  $t = NodeType::load("tocjs_page");
  if (!$t) { print "FAIL no-type\n"; return; }
  $active = $t->getThirdPartySetting("toc_js","toc_js_active",FALSE);
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.tocjs_page.default");
  $placed = $vd ? (bool) $vd->getComponent("toc_js") : FALSE;
  $ok = ($active === TRUE) && $placed;
  print ($ok ? "PASS" : "FAIL") . " active=" . var_export($active, TRUE) . " toc_field_placed=" . var_export($placed, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
