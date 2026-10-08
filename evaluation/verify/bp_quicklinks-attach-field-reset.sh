#!/usr/bin/env bash
# Execution RESET for bp_quicklinks "attach a Quicklinks-only Paragraphs field to Article":
# delete field_bpquick_nav from node.article entirely so the matching verify FAILS on empty
# state. Never touches the shipped bp_quicklinks paragraph type. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_bpquick_nav")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_bpquick_nav")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_bpquick_nav absent from node.article"
