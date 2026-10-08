#!/usr/bin/env bash
# Execution RESET: enable module and place Example Node Label with wrapper span, so verify
# FAILs until the agent changes the wrapper to h5.
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
  $fd->setComponent("extra_field_example_node_label", ["type" => "extra_field_example_node_label", "weight" => 20, "region" => "content", "settings" => ["link_to_entity" => FALSE, "wrapper" => "span"]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: extra_field_example_node_label wrapper=span"
