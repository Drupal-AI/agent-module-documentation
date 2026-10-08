#!/usr/bin/env bash
# Execution RESET: ensure a core link field field_li_pred exists on Article with plain 'optional'
# link text (title=1) and NO predefined allowed values, so verify FAILS until the agent switches
# the field to Link Icon's Predefined titles. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_li_pred")) {
    FieldStorageConfig::create([
      "field_name" => "field_li_pred", "entity_type" => "node",
      "type" => "link", "cardinality" => -1,
    ])->save();
  }
  $fc = FieldConfig::loadByName("node", "article", "field_li_pred");
  if (!$fc) {
    $fc = FieldConfig::create([
      "field_name" => "field_li_pred", "entity_type" => "node",
      "bundle" => "article", "label" => "Predefined Links",
    ]);
  }
  $fc->setSetting("title", 1);
  $fc->setSetting("title_predefined", "");
  $fc->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article field_li_pred title=1 (optional), no predefined values"
