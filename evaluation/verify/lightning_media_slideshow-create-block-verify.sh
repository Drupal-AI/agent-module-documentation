#!/usr/bin/env bash
# Execution VERIFY: PASS when a block content entity of type media_slideshow labelled
# 'LM Slideshow Task' exists and its field_slideshow_items references both the 'LM Slide A' and
# 'LM Slide B' media items. exit 0 = pass, 1 = fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $blocks = \Drupal::entityTypeManager()->getStorage("block_content")->loadByProperties(["info" => "LM Slideshow Task"]);
  $block = $blocks ? reset($blocks) : NULL;
  $storage = \Drupal::entityTypeManager()->getStorage("media");
  $wanted = [];
  foreach (["LM Slide A", "LM Slide B"] as $name) {
    $found = $storage->loadByProperties(["name" => $name]);
    if ($found) { $wanted[] = (string) reset($found)->id(); }
  }
  $referenced = [];
  if ($block && $block->hasField("field_slideshow_items")) {
    $referenced = array_map("strval", array_column($block->get("field_slideshow_items")->getValue(), "target_id"));
  }
  $checks = [
    "block_exists" => (bool) $block,
    "bundle" => $block && $block->bundle() === "media_slideshow",
    "fixtures_present" => count($wanted) === 2,
    "references_both" => count($wanted) === 2 && !array_diff($wanted, $referenced),
  ];
  $bad = array_keys(array_filter($checks, fn ($v) => !$v));
  print ($bad ? "FAIL wrong=" . implode(",", $bad) : "PASS")
    . " wanted=" . json_encode($wanted) . " referenced=" . json_encode($referenced) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
