#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# HARD (execution) RESET for telephone_formatter: ensure a telephone field field_eval_tel
# exists on node.article (create storage + field if missing), then force its
# node.article.default display component to a NON-telephone_formatter formatter (core
# basic_string) so the verify script FAILs on this clean state. The agent's task is to switch
# that field's display to telephone_formatter with format = 3 (RFC3966) and link = TRUE.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if (!\Drupal\field\Entity\FieldStorageConfig::loadByName("node", "field_eval_tel")) {
    \Drupal\field\Entity\FieldStorageConfig::create([
      "field_name" => "field_eval_tel", "entity_type" => "node", "type" => "telephone",
    ])->save();
  }
  if (!\Drupal\field\Entity\FieldConfig::loadByName("node", "article", "field_eval_tel")) {
    \Drupal\field\Entity\FieldConfig::create([
      "field_name" => "field_eval_tel", "entity_type" => "node", "bundle" => "article",
      "label" => "Eval Tel",
    ])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  if (!$vd) {
    $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->create([
      "targetEntityType" => "node", "bundle" => "article", "mode" => "default", "status" => TRUE,
    ]);
  }
  // Baseline: core basic_string formatter (raw text) -> verify must FAIL here.
  $vd->setComponent("field_eval_tel", [
    "type" => "basic_string", "settings" => [], "weight" => 50, "label" => "above",
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article field_eval_tel display -> basic_string (baseline; verify should FAIL)"
