#!/usr/bin/env bash
# Execution VERIFY for "add an interval field field_interval_task to Article".
# PASS when a field storage of type 'interval' named field_interval_task exists AND is
# attached to node.article. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  $fs = FieldStorageConfig::loadByName("node", "field_interval_task");
  $fc = FieldConfig::loadByName("node", "article", "field_interval_task");
  $type = $fs ? $fs->getType() : "none";
  $ok = ($fs && $fc && $type === "interval");
  print ($ok ? "PASS" : "FAIL") . " storage=" . ($fs ? "yes" : "no") . " instance=" . ($fc ? "yes" : "no") . " type=" . $type . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
