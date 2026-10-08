#!/usr/bin/env bash
# HARD execution verify for "style a block in the 'LBB Build Target' node's Layout Builder
# layout with Layout Builder Blocks". Two live checks, both must hold:
#   store  — a component in the node's layout has a non-empty bootstrap_styles.block_style with
#            at least one CSS class string.
#   render — the node rendered full actually emits that class (proves the render subscriber
#            applied it, i.e. the module did its job end-to-end).
# Prints PASS/FAIL and exits 0 (pass) / 1 (fail). Class-agnostic: reads whatever class the agent chose.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $nodes = \Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title" => "LBB Build Target"]);
  $node = $nodes ? reset($nodes) : NULL;
  if (!$node) { print "FAIL no-target-node\n"; return; }
  $classes = [];
  foreach ($node->get("layout_builder__layout")->getSections() as $section) {
    foreach ($section->getComponents() as $component) {
      $bs = $component->get("bootstrap_styles");
      if (!empty($bs["block_style"])) {
        array_walk_recursive($bs["block_style"], function ($v, $k) use (&$classes) {
          if ($k === "class" && is_string($v) && $v !== "" && $v !== "_none") { $classes[] = $v; }
        });
      }
    }
  }
  $store = count($classes) > 0;
  $render = FALSE;
  if ($store) {
    $build = \Drupal::entityTypeManager()->getViewBuilder("node")->view($node, "full");
    $html = (string) \Drupal::service("renderer")->renderInIsolation($build);
    foreach ($classes as $c) { if (strpos($html, $c) !== FALSE) { $render = TRUE; break; } }
  }
  print (($store && $render) ? "PASS" : "FAIL") . " store=" . ($store?1:0) . " render=" . ($render?1:0) . " classes=" . json_encode($classes) . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
