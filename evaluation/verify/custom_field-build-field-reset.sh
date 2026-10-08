#!/usr/bin/env bash
# Execution RESET: ensure content type cf_eval exists and REMOVE field_cf_task so verify FAILS
# on empty state until the agent builds it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!NodeType::load("cf_eval")) { NodeType::create(["type"=>"cf_eval","name"=>"CF Eval"])->save(); }
  if ($fc = FieldConfig::loadByName("node","cf_eval","field_cf_task")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node","field_cf_task")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: cf_eval present, field_cf_task removed"
