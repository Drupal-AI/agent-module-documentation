#!/usr/bin/env bash
# Execution VERIFY: PASS when field_lfaf_h2 targets 'article' with negate truthy (exclude).
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldConfig;
  $fc = FieldConfig::loadByName("node", "lfaf_h2", "field_lfaf_h2");
  if (!$fc) { print "FAIL no field field_lfaf_h2\n"; return; }
  $neg = $fc->getThirdPartySetting("link_field_autocomplete_filter", "negate");
  $isExclude = ($neg === TRUE || $neg === 1 || $neg === "1");
  $a = (array) ($fc->getThirdPartySetting("link_field_autocomplete_filter", "allowed_content_types") ?? []);
  $f = array_filter($a);
  $ids = array_unique(array_merge(array_keys($f), array_values($f)));
  $has = in_array("article", $ids, TRUE);
  $ok = ($has && ($isExclude));
  print ($ok ? "PASS" : "FAIL") . " negate=" . var_export($neg, TRUE) . " ids=" . implode(",", $ids) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
