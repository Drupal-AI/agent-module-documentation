#!/usr/bin/env bash
# Introspection SETUP: enable module, place Example Node Label on Article display with a KNOWN
# wrapper (h4), so an agent can read the submodule plugin setting back.
set -uo pipefail
cd /var/www/html
drush en extra_field_plus_example -y >/dev/null 2>&1
drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  if (!$fd) {
    $fd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->create([
      "targetEntityType" => "node", "bundle" => "article", "mode" => "default", "status" => TRUE,
    ]);
  }
  $fd->setComponent("extra_field_example_node_label", ["type" => "extra_field_example_node_label", "weight" => 20, "region" => "content", "settings" => ["link_to_entity" => FALSE, "wrapper" => "h4"]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: extra_field_example_node_label wrapper=h4"
