#!/usr/bin/env bash
# Execution RESET for bp_webform "attach a Webform-only Paragraphs field to Article":
# delete field_bpwf_block from node.article entirely so the matching verify FAILS on empty
# state. Never touches the shipped bp_webform paragraph type. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_bpwf_block")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_bpwf_block")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_bpwf_block absent from node.article"
