#!/usr/bin/env bash
# Execution VERIFY: PASS when flattax_task has third_party_settings.flat_taxonomy.flat == 1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  $v = Vocabulary::load("flattax_task");
  if (!$v) { print "FAIL no-vocab\n"; return; }
  $f = $v->getThirdPartySetting("flat_taxonomy","flat");
  print (($f == 1) ? "PASS" : "FAIL")." flat=".var_export($f, TRUE)."\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
