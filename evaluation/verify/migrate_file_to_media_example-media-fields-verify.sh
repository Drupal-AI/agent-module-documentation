#!/usr/bin/env bash
# Execution VERIFY: PASS when BOTH field_image_media and field_image2_media exist on Article as
# entity_reference fields targeting media (the fields the example step-2 migration needs). exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $ok = TRUE; $rep = [];
  foreach (["field_image_media","field_image2_media"] as $fn) {
    $fc = \Drupal\field\Entity\FieldConfig::loadByName("node","article",$fn);
    $good = $fc && $fc->getType() === "entity_reference" && $fc->getFieldStorageDefinition()->getSetting("target_type") === "media";
    $ok = $ok && $good;
    $rep[] = $fn . "=" . ($good ? "ok" : "missing");
  }
  print (($ok ? "PASS" : "FAIL")) . " " . implode(",", $rep) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
