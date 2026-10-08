#!/usr/bin/env bash
# Execution VERIFY (uuid_extra): PASS when node.article default form display has a uuid component
# whose widget type is 'uuid' (the uuid_extra read-only widget). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $c = $fd ? $fd->getComponent("uuid") : NULL;
  $ok = (!empty($c) && ($c["type"] ?? "") === "uuid");
  print ($ok ? "PASS" : "FAIL") . " widget=" . ($c["type"] ?? "none") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
