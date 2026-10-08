#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# MEDIUM (introspection) SETUP for fences: give node.article.default's body field KNOWN Fences
# settings that suppress the label and per-item wrappers (none) and wrap all items in a <ul>
# items wrapper, so an inspecting agent can read them from entity_view_display config. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $vd->getComponent("body");
  $c["third_party_settings"]["fences"] = [
    "fences_field_tag" => "div",
    "fences_field_classes" => "",
    "fences_field_items_wrapper_tag" => "ul",
    "fences_field_items_wrapper_classes" => "",
    "fences_field_item_tag" => "none",
    "fences_field_item_classes" => "",
    "fences_label_tag" => "none",
    "fences_label_classes" => "",
  ];
  $vd->setComponent("body", $c)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article.default body fences -> label=none, item=none, items_wrapper=ul"
