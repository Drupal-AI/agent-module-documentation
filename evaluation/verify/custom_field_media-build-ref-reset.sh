#!/usr/bin/env bash
# Execution RESET: ensure cfmedia_eval exists and REMOVE field_cfmedia_task so verify FAILS until
# the agent builds a Custom Field with an entity_reference(media) column. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!NodeType::load("cfmedia_eval")) { NodeType::create(["type"=>"cfmedia_eval","name"=>"CF Media Eval"])->save(); }
  if ($fc = FieldConfig::loadByName("node","cfmedia_eval","field_cfmedia_task")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node","field_cfmedia_task")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: cfmedia_eval present, field_cfmedia_task removed"
