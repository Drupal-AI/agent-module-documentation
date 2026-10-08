#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# MEDIUM (introspection) SETUP for telephone_formatter: create a telephone field
# field_eval_phone on node.article (storage + field), then set node.article.default's
# display for that field to the telephone_formatter formatter with a KNOWN set of settings
# (format = 2 / National, link = FALSE, default_country = US) so an inspecting agent can read
# them back from the entity_view_display config with drush. Idempotent (overwrites each run).
# Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if (!\Drupal\field\Entity\FieldStorageConfig::loadByName("node", "field_eval_phone")) {
    \Drupal\field\Entity\FieldStorageConfig::create([
      "field_name" => "field_eval_phone", "entity_type" => "node", "type" => "telephone",
    ])->save();
  }
  if (!\Drupal\field\Entity\FieldConfig::loadByName("node", "article", "field_eval_phone")) {
    \Drupal\field\Entity\FieldConfig::create([
      "field_name" => "field_eval_phone", "entity_type" => "node", "bundle" => "article",
      "label" => "Eval Phone",
    ])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  if (!$vd) {
    $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->create([
      "targetEntityType" => "node", "bundle" => "article", "mode" => "default", "status" => TRUE,
    ]);
  }
  $vd->setComponent("field_eval_phone", [
    "type" => "telephone_formatter",
    "settings" => ["format" => 2, "link" => FALSE, "default_country" => "US"],
    "weight" => 50, "label" => "above",
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article.default field_eval_phone -> telephone_formatter (format=2/National, link=FALSE, default_country=US)"
