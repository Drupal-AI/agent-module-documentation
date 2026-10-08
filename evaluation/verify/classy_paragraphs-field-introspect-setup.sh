#!/usr/bin/env bash
# MEDIUM setup: add a classy-paragraphs class field (a core entity_reference field whose
# target_type is classy_paragraphs_style) to the Article content type, so the agent can
# inspect the live site and report the field's target type / machine name. Cleanup removes it.
# SPDX-License-Identifier: GPL-2.0-or-later
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($f = FieldConfig::loadByName("node", "article", "field_eval_cp_style")) { $f->delete(); }
  if ($s = FieldStorageConfig::loadByName("node", "field_eval_cp_style")) { $s->delete(); }
  FieldStorageConfig::create([
    "field_name" => "field_eval_cp_style",
    "entity_type" => "node",
    "type" => "entity_reference",
    "settings" => ["target_type" => "classy_paragraphs_style"],
    "cardinality" => -1,
  ])->save();
  FieldConfig::create([
    "field_name" => "field_eval_cp_style",
    "entity_type" => "node",
    "bundle" => "article",
    "label" => "Style classes",
    "settings" => ["handler" => "default:classy_paragraphs_style", "handler_settings" => []],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_eval_cp_style (entity_reference -> classy_paragraphs_style) added to node.article"
