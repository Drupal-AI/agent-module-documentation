#!/usr/bin/env bash
# Execution VERIFY: PASS when an 'h5p'-type field field_h5p_task exists on node.article. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  $fs = FieldStorageConfig::loadByName("node", "field_h5p_task");
  $fc = FieldConfig::loadByName("node", "article", "field_h5p_task");
  $ok = ($fs && $fs->getType() === "h5p" && $fc);
  print ($ok ? "PASS" : "FAIL") . " storage_type=" . ($fs ? $fs->getType() : "none") . " field_on_article=" . ($fc ? "yes" : "no") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
