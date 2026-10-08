#!/usr/bin/env bash
# Execution RESET for "display a Double Field as a definition list".
# Ensures field_df_faq exists on Article (first = string question, second = long text answer)
# and forces its default view-display component back to the module's default formatter
# (double_field_unformatted_list) so verify FAILS until the agent switches it to
# double_field_html_list with list_type 'dl'. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  $fs = FieldStorageConfig::loadByName("node", "field_df_faq");
  if (!$fs) {
    $fs = FieldStorageConfig::create([
      "field_name" => "field_df_faq", "entity_type" => "node",
      "type" => "double_field", "cardinality" => -1,
    ]);
  }
  $fs->setSetting("storage", [
    "first"  => ["type" => "string", "maxlength" => 255, "precision" => 10, "scale" => 2, "datetime_type" => "datetime"],
    "second" => ["type" => "text",   "maxlength" => 255, "precision" => 10, "scale" => 2, "datetime_type" => "datetime"],
  ]);
  $fs->save();
  $fc = FieldConfig::loadByName("node", "article", "field_df_faq");
  if (!$fc) {
    $fc = FieldConfig::create([
      "field_name" => "field_df_faq", "entity_type" => "node",
      "bundle" => "article", "label" => "Frequently Asked Questions",
    ]);
  }
  $fc->setSettings([
    "first"  => ["label" => "Question", "min" => "", "max" => "", "list" => FALSE,
                 "allowed_values" => [], "required" => TRUE, "on_label" => "On", "off_label" => "Off"],
    "second" => ["label" => "Answer", "min" => "", "max" => "", "list" => FALSE,
                 "allowed_values" => [], "required" => TRUE, "on_label" => "On", "off_label" => "Off"],
  ])->save();
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_df_faq", ["type" => "double_field", "weight" => 73, "region" => "content"])->save();
  $subfield = [
    "hidden" => FALSE, "link" => FALSE, "format_type" => "medium",
    "thousand_separator" => "", "decimal_separator" => ".", "scale" => 2, "key" => FALSE,
  ];
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_df_faq", [
    "type" => "double_field_unformatted_list",
    "label" => "above",
    "weight" => 73,
    "region" => "content",
    "settings" => ["inline" => TRUE, "first" => $subfield, "second" => $subfield],
    "third_party_settings" => [],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article field_df_faq displayed with double_field_unformatted_list"
