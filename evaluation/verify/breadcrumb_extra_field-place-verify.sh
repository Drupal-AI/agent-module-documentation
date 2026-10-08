#!/usr/bin/env bash
# Execution VERIFY: PASS when the 'breadcrumb' extra field is placed (visible) on the Article
# default view display (component present in the content region). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $vd ? $vd->getComponent("breadcrumb") : NULL;
  $ok = !empty($c);
  print (($ok) ? "PASS" : "FAIL") . " component=" . var_export($c, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
