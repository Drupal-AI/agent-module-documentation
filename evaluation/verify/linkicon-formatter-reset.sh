#!/usr/bin/env bash
# Execution RESET: ensure a core link field field_li_task exists on Article and force its default
# view-display formatter to the plain core 'link' formatter (NOT linkicon), so verify FAILS until
# the agent switches it to the Link Icon formatter. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_li_task")) {
    FieldStorageConfig::create([
      "field_name" => "field_li_task", "entity_type" => "node",
      "type" => "link", "cardinality" => -1,
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_li_task")) {
    FieldConfig::create([
      "field_name" => "field_li_task", "entity_type" => "node",
      "bundle" => "article", "label" => "Task Links",
    ])->save();
  }
  $vd = \Drupal::service("entity_display.repository")->getViewDisplay("node", "article", "default");
  $vd->setComponent("field_li_task", [
    "type" => "link", "label" => "above", "weight" => 60, "region" => "content", "settings" => [],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article field_li_task displayed with core link formatter"
