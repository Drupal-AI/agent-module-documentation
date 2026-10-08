#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# MEDIUM (introspection) SETUP for fences: give node.article.default's body field a KNOWN set
# of Fences wrapper settings (field tag = section, label tag = h3) as third-party settings on
# the field formatter, so an inspecting agent can read them back from the entity_view_display
# config with drush. Idempotent (overwrites each run). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $vd->getComponent("body");
  $c["third_party_settings"]["fences"] = [
    "fences_field_tag" => "section",
    "fences_field_classes" => "",
    "fences_field_items_wrapper_tag" => "none",
    "fences_field_items_wrapper_classes" => "",
    "fences_field_item_tag" => "div",
    "fences_field_item_classes" => "",
    "fences_label_tag" => "h3",
    "fences_label_classes" => "",
  ];
  $vd->setComponent("body", $c)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article.default body fences -> field_tag=section, label_tag=h3"
