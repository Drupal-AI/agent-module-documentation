#!/usr/bin/env bash
# Execution VERIFY: PASS when the stored depth_level of the ttd_eval_h terms is correct:
# TTD Root=1, TTD Child=2, TTD Grand=3. Prints PASS/FAIL. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $rows = \Drupal::database()->query("SELECT name, depth_level FROM {taxonomy_term_field_data} WHERE vid=:v", [":v"=>"ttd_eval_h"])->fetchAllKeyed();
  $exp = ["TTD Root"=>1, "TTD Child"=>2, "TTD Grand"=>3];
  $ok = TRUE;
  foreach ($exp as $name=>$d) { if ((int)($rows[$name] ?? -1) !== $d) { $ok = FALSE; } }
  print ($ok ? "PASS" : "FAIL") . " depths=" . json_encode($rows) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
