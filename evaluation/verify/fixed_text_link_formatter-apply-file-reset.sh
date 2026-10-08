#!/usr/bin/env bash
# Execution RESET: ensure a file field field_ftlf_taskfile exists on Article displayed with a
# non-fixed file formatter (file_default), so verify FAILS until the agent switches it to
# fixed_text_file_url. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_ftlf_taskfile")) {
    FieldStorageConfig::create(["field_name"=>"field_ftlf_taskfile","entity_type"=>"node","type"=>"file"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_ftlf_taskfile")) {
    FieldConfig::create(["field_name"=>"field_ftlf_taskfile","entity_type"=>"node","bundle"=>"article","label"=>"FTLF Task File"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_ftlf_taskfile", [
    "type"=>"file_default","label"=>"hidden","weight"=>53,"region"=>"content","settings"=>[],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_ftlf_taskfile uses file_default formatter"
