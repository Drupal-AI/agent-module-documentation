#!/usr/bin/env bash
# Execution VERIFY: PASS when the slideshow media reference field accepts at most 6 values and
# is restricted to exactly the image and document media bundles. exit 0 = pass, 1 = fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $fs = \Drupal\field\Entity\FieldStorageConfig::loadByName("block_content", "field_slideshow_items");
  $fc = \Drupal\field\Entity\FieldConfig::loadByName("block_content", "media_slideshow", "field_slideshow_items");
  $bundles = [];
  if ($fc) {
    $s = $fc->getSettings();
    $bundles = array_values(array_filter((array) ($s["handler_settings"]["target_bundles"] ?? [])));
    sort($bundles);
  }
  $checks = [
    "cardinality" => $fs && (int) $fs->getCardinality() === 6,
    "target_bundles" => ($bundles === ["document", "image"]),
  ];
  $bad = array_keys(array_filter($checks, fn ($v) => !$v));
  print ($bad ? "FAIL wrong=" . implode(",", $bad) : "PASS")
    . " cardinality=" . ($fs ? $fs->getCardinality() : "none")
    . " target_bundles=" . json_encode($bundles) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
