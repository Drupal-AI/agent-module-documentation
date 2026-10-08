#!/usr/bin/env bash
# cleanup: field_htf_known + vocab htf_known removed
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($c = FieldConfig::loadByName("node", "article", "field_htf_known")) { $c->delete(); }
  if ($s = FieldStorageConfig::loadByName("node", "field_htf_known")) { $s->delete(); }
  if ($v = Vocabulary::load("htf_known")) { $v->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_htf_known + vocab htf_known removed"
