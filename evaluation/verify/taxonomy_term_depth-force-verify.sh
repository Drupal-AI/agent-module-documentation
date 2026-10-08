#!/usr/bin/env bash
# Execution VERIFY: PASS when TTD Kid's stored depth_level equals its true depth (2). Prints
# PASS/FAIL. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::database()->query("SELECT depth_level FROM {taxonomy_term_field_data} WHERE name=:n AND vid=:vid", [":n"=>"TTD Kid", ":vid"=>"ttd_eval_h2"])->fetchField();
  $ok = ((int)$v === 2);
  print ($ok ? "PASS" : "FAIL") . " kid_depth=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
