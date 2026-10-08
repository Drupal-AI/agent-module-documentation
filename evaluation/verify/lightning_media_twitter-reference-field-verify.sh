#!/usr/bin/env bash
# Execution VERIFY: PASS when Article has an entity_reference field field_lm_tweet targeting
# media, restricted to the tweet bundle, using the media_library_widget on the default form
# display. exit 0 = pass, 1 = fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $fc = \Drupal\field\Entity\FieldConfig::loadByName("node", "article", "field_lm_tweet");
  $fs = \Drupal\field\Entity\FieldStorageConfig::loadByName("node", "field_lm_tweet");
  $bundles = [];
  if ($fc) {
    $settings = $fc->getSettings();
    $bundles = array_values($settings["handler_settings"]["target_bundles"] ?? []);
    sort($bundles);
  }
  $display = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $component = $display ? $display->getComponent("field_lm_tweet") : NULL;
  $checks = [
    "storage" => $fs && $fs->getType() === "entity_reference" && $fs->getSetting("target_type") === "media",
    "field" => (bool) $fc,
    "target_bundles" => ($bundles === ["tweet"]),
    "widget" => $component && ($component["type"] ?? NULL) === "media_library_widget",
  ];
  $bad = array_keys(array_filter($checks, fn ($v) => !$v));
  print ($bad ? "FAIL wrong=" . implode(",", $bad) : "PASS")
    . " target_bundles=" . json_encode($bundles)
    . " widget=" . var_export($component["type"] ?? NULL, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
