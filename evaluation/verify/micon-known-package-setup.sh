#!/usr/bin/env bash
# Introspection SETUP: create a string_micon Icon field field_micon_known on Article and
# restrict its form-display widget to the `fa` package, so an inspecting agent can read back
# which package the widget is limited to. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_micon_known")) {
    FieldStorageConfig::create(["field_name"=>"field_micon_known","entity_type"=>"node","type"=>"string_micon"])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_micon_known")) {
    FieldConfig::create(["field_name"=>"field_micon_known","entity_type"=>"node","bundle"=>"article","label"=>"Known Icon"])->save();
  }
  $fd = \Drupal::service("entity_display.repository")->getFormDisplay("node","article","default");
  $fd->setComponent("field_micon_known", ["type"=>"string_micon","weight"=>50,"region"=>"content","settings"=>["packages"=>["fa"=>"fa"]]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_micon_known (string_micon) widget restricted to packages=[fa]"
