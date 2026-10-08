#!/usr/bin/env bash
# Execution RESET: ensure Article has an auto estimated_read_time field field_ert_auto
# (view_mode=default, wpm=230) and delete any node titled 'ERT Auto Node', so the read-time
# value only appears after the agent creates a node with a long body. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_ert_auto")) {
    FieldStorageConfig::create(["field_name" => "field_ert_auto", "entity_type" => "node", "type" => "estimated_read_time"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_ert_auto")) {
    FieldConfig::create(["field_name" => "field_ert_auto", "entity_type" => "node", "bundle" => "article", "label" => "Auto Read Time"])->save();
  }
  $f = FieldConfig::loadByName("node", "article", "field_ert_auto");
  $f->setSetting("view_mode", "default");
  $f->setSetting("words_per_minute", 230);
  $f->save();
  $ids = \Drupal::entityTypeManager()->getStorage("node")->getQuery()->accessCheck(FALSE)->condition("title", "ERT Auto Node")->execute();
  foreach (\Drupal::entityTypeManager()->getStorage("node")->loadMultiple($ids) as $n) { $n->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_ert_auto present on Article; no ERT Auto Node"
