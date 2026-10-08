#!/usr/bin/env bash
# Execution VERIFY: PASS when a media reference field field_mf2m_task_media was created on mf2m_ht
# (entity_reference to a media entity). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $fc = \Drupal\field\Entity\FieldConfig::loadByName("node","mf2m_ht","field_mf2m_task_media");
  $type = $fc ? $fc->getType() : "none";
  $target = $fc ? ($fc->getFieldStorageDefinition()->getSetting("target_type")) : "none";
  $ok = $fc && $type === "entity_reference" && $target === "media";
  print (($ok ? "PASS" : "FAIL")) . " type=" . $type . " target=" . $target . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
