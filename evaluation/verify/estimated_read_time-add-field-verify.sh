#!/usr/bin/env bash
# Execution VERIFY: PASS when Article has an estimated_read_time field field_ert_task whose
# words_per_minute setting is 240. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  $fs = FieldStorageConfig::loadByName("node", "field_ert_task");
  $fc = FieldConfig::loadByName("node", "article", "field_ert_task");
  $wpm = $fc ? $fc->getSetting("words_per_minute") : NULL;
  $ok = $fs && $fs->getType() === "estimated_read_time" && $fc && (int) $wpm === 240;
  print ($ok ? "PASS" : "FAIL") . " type=" . ($fs ? $fs->getType() : "none") . " wpm=" . var_export($wpm, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
