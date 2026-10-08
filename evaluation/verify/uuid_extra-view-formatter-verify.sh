#!/usr/bin/env bash
# Execution VERIFY (uuid_extra): PASS when node.article default view display has a uuid component
# whose formatter type is 'uuid' (the uuid_extra formatter). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $vd ? $vd->getComponent("uuid") : NULL;
  $ok = (!empty($c) && ($c["type"] ?? "") === "uuid");
  print ($ok ? "PASS" : "FAIL") . " formatter=" . ($c["type"] ?? "none") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
