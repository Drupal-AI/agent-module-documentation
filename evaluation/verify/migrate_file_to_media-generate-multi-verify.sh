#!/usr/bin/env bash
# Execution VERIFY: PASS when BOTH field_mf2m_a_media and field_mf2m_b_media were created on
# mf2m_ht2 as entity_reference fields targeting media. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $ok = TRUE; $rep = [];
  foreach (["field_mf2m_a_media","field_mf2m_b_media"] as $fn) {
    $fc = \Drupal\field\Entity\FieldConfig::loadByName("node","mf2m_ht2",$fn);
    $good = $fc && $fc->getType() === "entity_reference" && $fc->getFieldStorageDefinition()->getSetting("target_type") === "media";
    $ok = $ok && $good;
    $rep[] = $fn . "=" . ($good ? "ok" : "missing");
  }
  print (($ok ? "PASS" : "FAIL")) . " " . implode(",", $rep) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
