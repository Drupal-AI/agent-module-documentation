#!/usr/bin/env bash
# Introspection SETUP: two entity_reference(->contact_form) fields on Article; only
# field_cfmt_on uses contact_field_formatter, field_cfmt_off uses the default label
# formatter. The agent must inspect the display and say which one renders the form.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  foreach (["field_cfmt_on", "field_cfmt_off"] as $fn) {
    if (!FieldStorageConfig::loadByName("node", $fn)) {
      FieldStorageConfig::create([
        "field_name" => $fn, "entity_type" => "node",
        "type" => "entity_reference", "settings" => ["target_type" => "contact_form"],
      ])->save();
    }
    if (!FieldConfig::loadByName("node", "article", $fn)) {
      FieldConfig::create(["field_name" => $fn, "entity_type" => "node", "bundle" => "article", "label" => $fn])->save();
    }
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_cfmt_on", ["type" => "contact_field_formatter", "region" => "content", "weight" => 50])->save();
  $vd->setComponent("field_cfmt_off", ["type" => "entity_reference_label", "region" => "content", "weight" => 51])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_cfmt_on=contact_field_formatter, field_cfmt_off=entity_reference_label"
