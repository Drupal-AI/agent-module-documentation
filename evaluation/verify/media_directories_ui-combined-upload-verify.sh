#!/usr/bin/env bash
# Execution VERIFY for "enable combined upload in the deprecated UI submodule".
# PASS when media_directories_ui.settings has enable_combined_upload === TRUE and
# combined_upload_media_types contains exactly the image and document media types (order
# irrelevant), and both of those media types really exist on the site.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $config = \Drupal::config("media_directories_ui.settings");
  $enabled = $config->get("enable_combined_upload") === TRUE;
  $types = array_values(array_filter((array) ($config->get("combined_upload_media_types") ?: [])));
  sort($types);
  $types_ok = ($types === ["document", "image"]);

  $storage = \Drupal::entityTypeManager()->getStorage("media_type");
  $exist = $storage->load("image") !== NULL && $storage->load("document") !== NULL;

  $ok = $enabled && $types_ok && $exist;
  print ($ok ? "PASS" : "FAIL")
    . " enable_combined_upload=" . var_export($config->get("enable_combined_upload"), TRUE)
    . " types=" . json_encode($types)
    . " bundles_exist=" . var_export($exist, TRUE) . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
