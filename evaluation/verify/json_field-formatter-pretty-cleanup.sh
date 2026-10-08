#!/usr/bin/env bash
# Introspection CLEANUP: remove field_jf_plain and field_jf_fancy (and their display
# components) from node.article. Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  foreach (["field_jf_plain", "field_jf_fancy"] as $fn) {
    if ($fc = FieldConfig::loadByName("node", "article", $fn)) { $fc->delete(); }
    if ($fs = FieldStorageConfig::loadByName("node", $fn)) { $fs->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_jf_plain and field_jf_fancy removed from node.article"
