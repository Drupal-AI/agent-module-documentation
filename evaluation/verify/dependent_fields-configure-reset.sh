#!/usr/bin/env bash
# Execution RESET: parent + child entity_reference fields on Article, child using the DEFAULT
# reference method (default:node), NOT dependent_fields_selection, so verify FAILS until set.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  foreach (["field_dft_parent","field_dft_child"] as $fn) {
    if (!FieldStorageConfig::loadByName("node", $fn)) {
      FieldStorageConfig::create(["field_name" => $fn, "entity_type" => "node", "type" => "entity_reference", "settings" => ["target_type" => "node"]])->save();
    }
  }
  if (!FieldConfig::loadByName("node","article","field_dft_parent")) {
    FieldConfig::create(["field_name"=>"field_dft_parent","entity_type"=>"node","bundle"=>"article","label"=>"DFT Parent","settings"=>["handler"=>"default:node","handler_settings"=>[]]])->save();
  }
  $child = FieldConfig::loadByName("node","article","field_dft_child");
  if (!$child) {
    $child = FieldConfig::create(["field_name"=>"field_dft_child","entity_type"=>"node","bundle"=>"article","label"=>"DFT Child"]);
  }
  $child->setSetting("handler", "default:node");
  $child->setSetting("handler_settings", []);
  $child->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article field_dft_child uses default:node handler"
