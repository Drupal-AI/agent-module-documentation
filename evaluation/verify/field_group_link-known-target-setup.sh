#!/usr/bin/env bash
# Introspection SETUP: build a namespaced Article view mode "fgl_known" carrying TWO
# field_group_link groups — group_fgl_card (target = the link field field_fgl_dest) and
# group_fgl_plain (a non-link field_group formatter) — so an inspecting agent must read the
# live entity_view_display to find which group is the Link group and where it points.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\Core\Entity\Entity\EntityViewMode;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\field\Entity\FieldStorageConfig;
  if (!EntityViewMode::load("node.fgl_known")) {
    EntityViewMode::create([
      "id" => "node.fgl_known", "targetEntityType" => "node", "label" => "FGL Known",
    ])->save();
  }
  foreach ([["field_fgl_dest", "link"], ["field_fgl_blurb", "string"]] as [$fn, $type]) {
    if (!FieldStorageConfig::loadByName("node", $fn)) {
      FieldStorageConfig::create([
        "field_name" => $fn, "entity_type" => "node", "type" => $type,
      ])->save();
    }
    if (!FieldConfig::loadByName("node", "article", $fn)) {
      FieldConfig::create([
        "field_name" => $fn, "entity_type" => "node", "bundle" => "article",
        "label" => ($fn === "field_fgl_dest" ? "FGL Destination" : "FGL Blurb"),
      ])->save();
    }
  }
  $s = \Drupal::entityTypeManager()->getStorage("entity_view_display");
  $vd = $s->load("node.article.fgl_known") ?: $s->create([
    "targetEntityType" => "node", "bundle" => "article", "mode" => "fgl_known", "status" => TRUE,
  ]);
  $vd->setStatus(TRUE);
  $vd->setComponent("field_fgl_blurb", ["type" => "string", "label" => "hidden", "weight" => 1, "region" => "content"]);
  $vd->setThirdPartySetting("field_group", "group_fgl_card", [
    "children" => ["field_fgl_blurb"], "label" => "FGL Card", "parent_name" => "",
    "region" => "content", "weight" => 5, "format_type" => "link",
    "format_settings" => [
      "label" => "FGL Card", "classes" => "fgl-card", "id" => "",
      "show_empty_fields" => FALSE, "label_as_html" => FALSE,
      "target" => "field_fgl_dest", "custom_uri" => "", "target_attribute" => "_blank",
    ],
  ]);
  $vd->setThirdPartySetting("field_group", "group_fgl_plain", [
    "children" => [], "label" => "FGL Plain", "parent_name" => "",
    "region" => "content", "weight" => 6, "format_type" => "html_element",
    "format_settings" => [
      "label" => "FGL Plain", "classes" => "", "id" => "",
      "show_empty_fields" => FALSE, "label_as_html" => FALSE,
      "element" => "div", "show_label" => FALSE, "label_element" => "h3",
      "label_element_classes" => "", "attributes" => "", "effect" => "none",
      "speed" => "fast", "required_fields" => FALSE,
    ],
  ]);
  $vd->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article.fgl_known has group_fgl_card (format_type link, target=field_fgl_dest, _blank) + group_fgl_plain (html_element)"
