#!/usr/bin/env bash
# Introspection SETUP (sdc_display): add a field group (group_sdcd_known) using the
# 'sdc_display' (Single Directory Component) formatter on the Article default view display.
# Config-only. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setThirdPartySetting("field_group", "group_sdcd_known", [
    "label" => "Card", "children" => [], "parent_name" => "", "region" => "content", "weight" => 96,
    "format_type" => "sdc_display",
    "format_settings" => ["component" => ["machine_name" => "olivero:teaser"]],
  ]);
  $vd->save();
' >/dev/null 2>&1 || true
echo "setup: node.article view display has field group group_sdcd_known (format_type sdc_display)"
exit 0
