#!/usr/bin/env bash
# Execution VERIFY: PASS when field_spt2 is a scheduled_publish field on Article that allows
# MULTIPLE (unlimited) values (cardinality -1). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  $fs = FieldStorageConfig::loadByName("node","field_spt2");
  $fc = FieldConfig::loadByName("node","article","field_spt2");
  $type = $fs ? $fs->getType() : "none";
  $card = $fs ? $fs->getCardinality() : 0;
  $ok = ($fs && $fc && $type === "scheduled_publish" && $card === -1);
  print ($ok ? "PASS" : "FAIL") . " type=" . $type . " cardinality=" . $card . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
