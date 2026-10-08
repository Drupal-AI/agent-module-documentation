#!/usr/bin/env bash
# Execution VERIFY for "default view modes for embedded media on mdb_task_format".
# PASS when on the live filter.format.mdb_task_format:
#   * media_directories_default_view_mode is enabled,
#   * its weight is LOWER than media_embed's (it must run first),
#   * settings.view_mode_mapping maps the image bundle to the 'embedded' view mode,
#   * and the filter really rewrites markup: running the format's filter over a
#     <drupal-media> tag with no data-view-mode injects data-view-mode="embedded".
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  use Drupal\filter\Entity\FilterFormat;

  $format = FilterFormat::load("mdb_task_format");
  if (!$format) { print "FAIL format=missing\n"; return; }

  $coll = $format->filters();
  $vm = $coll->has("media_directories_default_view_mode") ? $coll->get("media_directories_default_view_mode") : NULL;
  $embed = $coll->has("media_embed") ? $coll->get("media_embed") : NULL;

  $on = $vm && $vm->status;
  $order_ok = $on && $embed && $embed->status && ((int) $vm->weight < (int) $embed->weight);
  $mapping = $on ? ($vm->settings["view_mode_mapping"] ?? []) : [];
  $map_ok = (($mapping["image"] ?? NULL) === "embedded");

  // Behavioural check: feed the plugin a tag for a real image media item.
  $applies = FALSE;
  $media = \Drupal::entityTypeManager()->getStorage("media")->loadByProperties(["name" => "MDB task image"]);
  if ($on && $media) {
    $item = reset($media);
    $html = "<p><drupal-media data-entity-type=\"media\" data-entity-uuid=\"" . $item->uuid() . "\"></drupal-media></p>";
    $processed = (string) $vm->process($html, "en")->getProcessedText();
    $applies = str_contains($processed, "data-view-mode=\"embedded\"");
  }

  $ok = $on && $order_ok && $map_ok && $applies;
  print ($ok ? "PASS" : "FAIL")
    . " enabled=" . var_export($on, TRUE)
    . " order(vm<embed)=" . var_export($order_ok, TRUE)
    . " mapping=" . json_encode($mapping)
    . " rewrites_markup=" . var_export($applies, TRUE) . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
