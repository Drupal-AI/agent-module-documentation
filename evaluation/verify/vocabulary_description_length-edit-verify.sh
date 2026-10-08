#!/usr/bin/env bash
# Execution VERIFY: PASS when vocabulary vdl_edit exists and now has a long (>=200 char)
# multi-line description.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::entityTypeManager()->getStorage("taxonomy_vocabulary")->load("vdl_edit");
  $desc = $v ? (string) $v->getDescription() : "";
  $ok = ($v !== NULL) && (mb_strlen($desc) >= 200) && (strpos($desc, "\n") !== FALSE);
  print ($ok ? "PASS" : "FAIL") . " exists=" . ($v?"yes":"no") . " len=" . mb_strlen($desc) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
