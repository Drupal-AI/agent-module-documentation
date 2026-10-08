#!/usr/bin/env bash
# Execution RESET for bp_statistics "attach a Statistics-only Paragraphs field to Article":
# delete field_bpstat_panel from node.article entirely so the matching verify FAILS on empty
# state. Never touches the shipped bp_statistics / bp_stat paragraph types. Idempotent.
# Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_bpstat_panel")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_bpstat_panel")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_bpstat_panel absent from node.article"
