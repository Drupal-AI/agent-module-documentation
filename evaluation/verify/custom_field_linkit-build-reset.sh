#!/usr/bin/env bash
# Execution RESET (custom_field_linkit): cf_lk_eval exists, field_cf_lk REMOVED. Agent must build a
# Custom Field with a uri column and the linkit_url widget. verify FAILs on empty. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType; use Drupal\field\Entity\FieldStorageConfig; use Drupal\field\Entity\FieldConfig;
  if (!NodeType::load("cf_lk_eval")) { NodeType::create(["type"=>"cf_lk_eval","name"=>"CF Linkit Eval"])->save(); }
  if ($fc = FieldConfig::loadByName("node","cf_lk_eval","field_cf_lk")) { try { $fc->delete(); } catch (\Throwable $e) {} }
  if ($fs = FieldStorageConfig::loadByName("node","field_cf_lk")) { try { $fs->delete(); } catch (\Throwable $e) {} }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: cf_lk_eval present, no field_cf_lk"
