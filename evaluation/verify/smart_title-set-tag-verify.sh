#!/usr/bin/env bash
# Execution VERIFY: PASS when node.article.default smart_title settings have tag === h1 and
# link === FALSE. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $s = $vd ? $vd->getThirdPartySetting("smart_title", "settings", []) : [];
  $tag = $s["smart_title__tag"] ?? NULL;
  $link = $s["smart_title__link"] ?? NULL;
  $ok = ($tag === "h1" && $link === FALSE);
  print ($ok ? "PASS" : "FAIL") . " tag=" . var_export($tag, TRUE) . " link=" . var_export($link, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
