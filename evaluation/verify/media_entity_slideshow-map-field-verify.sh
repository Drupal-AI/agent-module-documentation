#!/usr/bin/env bash
# Execution VERIFY: PASS when media type mes_fixed's source_field is field_mes_slides and that
# entity_reference field exists on the type. Exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\media\Entity\MediaType;
  use Drupal\field\Entity\FieldConfig;
  $t = MediaType::load("mes_fixed");
  if (!$t) { print "FAIL no-type\n"; return; }
  $sf = $t->get("source_configuration")["source_field"] ?? "";
  $exists = ($sf === "field_mes_slides") && FieldConfig::loadByName("media","mes_fixed","field_mes_slides");
  print ($exists ? "PASS" : "FAIL") . " source_field=" . $sf . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
