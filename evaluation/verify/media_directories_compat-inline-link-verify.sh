#!/usr/bin/env bash
# Execution VERIFY for "render legacy 'default' display-mode embeds as download links".
# PASS when, on the live site, filter.format.mdc_inline_format has
# media_directories_legacy_embed enabled with settings.inline_display_modes containing
# 'default', ordered before media_embed, AND processing a legacy <drupal-entity …
# data-entity-embed-display="view_mode:media.default"> yields an <a href> link to the media's
# file (not a <drupal-media> tag), while a "full" display-mode embed still becomes
# <drupal-media>. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  use Drupal\filter\Entity\FilterFormat;

  $format = FilterFormat::load("mdc_inline_format");
  if (!$format) { print "FAIL format=missing\n"; return; }
  $coll = $format->filters();
  $legacy = $coll->has("media_directories_legacy_embed") ? $coll->get("media_directories_legacy_embed") : NULL;
  $embed = $coll->has("media_embed") ? $coll->get("media_embed") : NULL;

  $on = $legacy && $legacy->status;
  $modes = $on ? array_values(array_filter((array) ($legacy->settings["inline_display_modes"] ?? []))) : [];
  $mode_ok = in_array("default", $modes, TRUE);
  $order_ok = $on && $embed && $embed->status && ((int) $legacy->weight < (int) $embed->weight);

  $inline_ok = FALSE;
  $media_ok = FALSE;
  $items = \Drupal::entityTypeManager()->getStorage("media")->loadByProperties(["name" => "MDC inline media"]);
  if ($on && $items) {
    $uuid = reset($items)->uuid();
    $mk = function (string $mode) use ($uuid) {
      return "<p><drupal-entity data-entity-type=\"media\" data-entity-uuid=\"" . $uuid . "\""
        . " data-entity-embed-display=\"view_mode:media." . $mode . "\"></drupal-entity></p>";
    };
    $a = (string) $legacy->process($mk("default"), "en")->getProcessedText();
    $inline_ok = str_contains($a, "<a ") && str_contains($a, "href=") && !str_contains($a, "<drupal-media");
    $b = (string) $legacy->process($mk("full"), "en")->getProcessedText();
    $media_ok = str_contains($b, "<drupal-media") && str_contains($b, "data-view-mode=\"full\"");
  }

  $ok = $on && $mode_ok && $order_ok && $inline_ok && $media_ok;
  print ($ok ? "PASS" : "FAIL")
    . " enabled=" . var_export($on, TRUE)
    . " inline_display_modes=" . json_encode($modes)
    . " order=" . var_export($order_ok, TRUE)
    . " default_becomes_link=" . var_export($inline_ok, TRUE)
    . " full_becomes_media=" . var_export($media_ok, TRUE) . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
