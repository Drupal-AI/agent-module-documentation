#!/usr/bin/env bash
# Execution VERIFY: PASS when an ExtraFieldDisplay plugin with id efeval_greeting is
# registered, its pseudo-field extra_field_efeval_greeting is placed on
# core.entity_view_display.node.article.default, and rendering an Article in the default view
# mode really emits the marker string EFEVAL-OK. A throwaway node is created and deleted.
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $manager = \Drupal::service("plugin.manager.extra_field_display");
  $has = $manager->hasDefinition("efeval_greeting");
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $placed = $vd && $vd->getComponent("extra_field_efeval_greeting") !== NULL;
  $rendered = FALSE;
  if ($has && $placed) {
    $storage = \Drupal::entityTypeManager()->getStorage("node");
    $node = $storage->create(["type" => "article", "title" => "extra_field eval probe"]);
    $node->save();
    $build = \Drupal::entityTypeManager()->getViewBuilder("node")->view($node, "default");
    $html = (string) \Drupal::service("renderer")->renderInIsolation($build);
    $rendered = str_contains($html, "EFEVAL-OK");
    $node->delete();
  }
  $ok = $has && $placed && $rendered;
  print ($ok ? "PASS" : "FAIL") . " definition=" . ($has ? "yes" : "no")
    . " placed=" . ($placed ? "yes" : "no")
    . " rendered_marker=" . ($rendered ? "yes" : "no") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
