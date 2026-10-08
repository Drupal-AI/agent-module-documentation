#!/usr/bin/env bash
# cleanup: field_htf_sep + vocab htf_sep removed
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($c = FieldConfig::loadByName("node", "article", "field_htf_sep")) { $c->delete(); }
  if ($s = FieldStorageConfig::loadByName("node", "field_htf_sep")) { $s->delete(); }
  if ($v = Vocabulary::load("htf_sep")) { $v->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_htf_sep + vocab htf_sep removed"
