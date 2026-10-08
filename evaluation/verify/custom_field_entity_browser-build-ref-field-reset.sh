#!/usr/bin/env bash
# Execution RESET: ensure cfeb_eval, REMOVE field_cfeb_ref so verify FAILS until built.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!NodeType::load("cfeb_eval")) { NodeType::create(["type"=>"cfeb_eval","name"=>"CFEB Eval"])->save(); }
  if ($fc=FieldConfig::loadByName("node","cfeb_eval","field_cfeb_ref")) { $fc->delete(); }
  if ($fs=FieldStorageConfig::loadByName("node","field_cfeb_ref")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: cfeb_eval present, field_cfeb_ref removed"
