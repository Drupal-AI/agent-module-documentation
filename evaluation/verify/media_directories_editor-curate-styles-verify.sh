#!/usr/bin/env bash
# Execution VERIFY for "curate the embed dialog image styles".
# PASS when media_directories_editor.settings:embed_dialog.image_styles contains exactly
# ['large', 'medium'] (order irrelevant) and both image styles really exist on the site.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $styles = array_values(array_filter((array) (\Drupal::config("media_directories_editor.settings")->get("embed_dialog.image_styles") ?: [])));
  sort($styles);
  $set_ok = ($styles === ["large", "medium"]);

  $storage = \Drupal::entityTypeManager()->getStorage("image_style");
  $exist = $storage->load("large") !== NULL && $storage->load("medium") !== NULL;

  $ok = $set_ok && $exist;
  print ($ok ? "PASS" : "FAIL") . " image_styles=" . json_encode($styles) . " styles_exist=" . var_export($exist, TRUE) . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
