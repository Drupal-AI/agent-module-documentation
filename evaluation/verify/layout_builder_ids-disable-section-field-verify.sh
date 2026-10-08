#!/usr/bin/env bash
# Execution VERIFY: PASS when section_id === 0 and block_id still enabled. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c=\Drupal::config("layout_builder_ids.settings");
  $b=$c->get("block_id"); $s=$c->get("section_id");
  $ok = ((int)$s === 0) && ((int)$b === 1);
  print ($ok?"PASS":"FAIL")." block_id=".var_export($b,TRUE)." section_id=".var_export($s,TRUE)."\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
