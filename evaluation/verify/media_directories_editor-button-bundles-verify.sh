#!/usr/bin/env bash
# Execution VERIFY for "restrict the Media Directories embed button to specific bundles".
# PASS when the embed button config entity embed.button.media_directories exists, still
# targets media through the module's entity browser, and its type_settings.bundles is exactly
# ['image', 'document'] (order irrelevant), with both media types present on the site.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $config = \Drupal::config("embed.button.media_directories");
  if ($config->isNew()) { print "FAIL button=missing\n"; return; }

  $entity_type = $config->get("type_settings.entity_type");
  $browser = $config->get("type_settings.entity_browser");
  $bundles = array_values(array_filter((array) ($config->get("type_settings.bundles") ?: [])));
  sort($bundles);

  $bundles_ok = ($bundles === ["document", "image"]);
  $wiring_ok = ($entity_type === "media") && ($browser === "media_directories_editor_browser");

  $storage = \Drupal::entityTypeManager()->getStorage("media_type");
  $exist = $storage->load("image") !== NULL && $storage->load("document") !== NULL;

  $ok = $bundles_ok && $wiring_ok && $exist;
  print ($ok ? "PASS" : "FAIL")
    . " bundles=" . json_encode($bundles)
    . " entity_type=" . var_export($entity_type, TRUE)
    . " entity_browser=" . var_export($browser, TRUE)
    . " bundles_exist=" . var_export($exist, TRUE) . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
