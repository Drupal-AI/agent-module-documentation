#!/usr/bin/env bash
# Execution VERIFY: PASS when a media type lm_gallery exists using the core Image source,
# Lightning Media's hook_ENTITY_TYPE_insert() has attached field_media_in_library to it with
# a boolean_checkbox widget on the default form display, and that field's default value has
# been changed to FALSE so new items are hidden from the media library.
# exit 0 = pass, 1 = fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\media\Entity\MediaType;
  use Drupal\field\Entity\FieldConfig;
  $checks = [];
  $type = MediaType::load("lm_gallery");
  $checks["type_exists"] = (bool) $type;
  $checks["source_is_image"] = $type && $type->getSource()->getPluginId() === "image";
  $field = FieldConfig::loadByName("media", "lm_gallery", "field_media_in_library");
  $checks["in_library_field"] = (bool) $field;
  $default = NULL;
  if ($field) {
    $values = $field->getDefaultValueLiteral();
    $default = $values ? $values[0]["value"] : NULL;
  }
  $checks["default_is_false"] = ($default !== NULL && !$default);
  $display = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("media.lm_gallery.default");
  $component = $display ? $display->getComponent("field_media_in_library") : NULL;
  $checks["form_widget"] = $component && ($component["type"] ?? NULL) === "boolean_checkbox";
  $bad = array_keys(array_filter($checks, fn ($v) => !$v));
  print ($bad ? "FAIL wrong=" . implode(",", $bad) : "PASS")
    . " source=" . ($type ? $type->getSource()->getPluginId() : "none")
    . " default=" . var_export($default, TRUE)
    . " widget=" . var_export($component["type"] ?? NULL, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
