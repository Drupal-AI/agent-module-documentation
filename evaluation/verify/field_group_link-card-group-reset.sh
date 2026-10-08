#!/usr/bin/env bash
# Execution RESET: prepare a namespaced Article view mode "fgl_task" containing the fields
# field_fgl_task_link (link) and field_fgl_task_body (string) as plain components, and remove
# ANY field_group groups from it — so verify FAILS until the agent creates the link group.
# Creates the view mode/fields if missing. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\Core\Entity\Entity\EntityViewMode;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\field\Entity\FieldStorageConfig;
  if (!EntityViewMode::load("node.fgl_task")) {
    EntityViewMode::create([
      "id" => "node.fgl_task", "targetEntityType" => "node", "label" => "FGL Task",
    ])->save();
  }
  foreach ([["field_fgl_task_link", "link"], ["field_fgl_task_body", "string"]] as [$fn, $type]) {
    if (!FieldStorageConfig::loadByName("node", $fn)) {
      FieldStorageConfig::create([
        "field_name" => $fn, "entity_type" => "node", "type" => $type,
      ])->save();
    }
    if (!FieldConfig::loadByName("node", "article", $fn)) {
      FieldConfig::create([
        "field_name" => $fn, "entity_type" => "node", "bundle" => "article",
        "label" => ($fn === "field_fgl_task_link" ? "FGL Task Link" : "FGL Task Body"),
      ])->save();
    }
  }
  $s = \Drupal::entityTypeManager()->getStorage("entity_view_display");
  $vd = $s->load("node.article.fgl_task") ?: $s->create([
    "targetEntityType" => "node", "bundle" => "article", "mode" => "fgl_task", "status" => TRUE,
  ]);
  $vd->setStatus(TRUE);
  $vd->setComponent("field_fgl_task_body", ["type" => "string", "label" => "hidden", "weight" => 1, "region" => "content"]);
  foreach (array_keys($vd->getThirdPartySettings("field_group")) as $g) {
    $vd->unsetThirdPartySetting("field_group", $g);
  }
  $vd->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article.fgl_task display has field_fgl_task_body component and NO field_group groups"
