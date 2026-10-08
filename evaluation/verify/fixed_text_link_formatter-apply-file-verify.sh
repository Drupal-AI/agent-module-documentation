#!/usr/bin/env bash
# Execution VERIFY: PASS when field_ftlf_taskfile on node.article.default uses the
# fixed_text_file_url formatter with a non-empty link_text. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $vd ? $vd->getComponent("field_ftlf_taskfile") : NULL;
  $type = $c["type"] ?? "none";
  $lt = $c["settings"]["link_text"] ?? "";
  $ok = ($type === "fixed_text_file_url") && ($lt !== "");
  print ($ok ? "PASS" : "FAIL") . " type=" . $type . " link_text=" . ($lt !== "" ? $lt : "(empty)") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
