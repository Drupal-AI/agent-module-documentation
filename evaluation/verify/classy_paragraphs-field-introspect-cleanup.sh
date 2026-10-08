#!/usr/bin/env bash
# MEDIUM cleanup: remove the field_eval_cp_style field + storage from node.article.
# SPDX-License-Identifier: GPL-2.0-or-later
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($f = FieldConfig::loadByName("node", "article", "field_eval_cp_style")) { $f->delete(); }
  if ($s = FieldStorageConfig::loadByName("node", "field_eval_cp_style")) { $s->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_eval_cp_style removed from node.article"
