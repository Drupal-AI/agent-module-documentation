#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# MEDIUM (introspection) CLEANUP for telephone_formatter: restore baseline by removing the
# field_eval_phone telephone field (field config + storage) from node.article, which also
# drops its display component. Idempotent (guarded deletes). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($fc = \Drupal\field\Entity\FieldConfig::loadByName("node", "article", "field_eval_phone")) { $fc->delete(); }
  if ($fs = \Drupal\field\Entity\FieldStorageConfig::loadByName("node", "field_eval_phone")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: node.article field_eval_phone removed"
