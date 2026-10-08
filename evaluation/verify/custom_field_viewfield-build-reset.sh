#!/usr/bin/env bash
# Execution RESET (custom_field_viewfield): ensure content type cf_vf_eval exists and REMOVE any
# field_cf_vf, so the site has no viewfield column. verify FAILs until the agent builds a Custom
# Field with a viewfield column. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!NodeType::load("cf_vf_eval")) { NodeType::create(["type"=>"cf_vf_eval","name"=>"CF Viewfield Eval"])->save(); }
  if ($fc = FieldConfig::loadByName("node","cf_vf_eval","field_cf_vf")) { try { $fc->delete(); } catch (\Throwable $e) {} }
  if ($fs = FieldStorageConfig::loadByName("node","field_cf_vf")) { try { $fs->delete(); } catch (\Throwable $e) {} }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: cf_vf_eval present, no field_cf_vf (no viewfield column yet)"
