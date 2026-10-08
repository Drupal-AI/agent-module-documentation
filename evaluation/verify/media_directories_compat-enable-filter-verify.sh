#!/usr/bin/env bash
# Execution VERIFY for "enable legacy embed compatibility on mdc_task_format".
# PASS when, on the live site:
#   * media_directories_legacy_embed is enabled on filter.format.mdc_task_format,
#   * its weight is LOWER than media_embed's (it must run first — it produces <drupal-media>),
#   * and it really converts markup: a <drupal-entity data-entity-type="media"
#     data-entity-embed-display="view_mode:media.full" data-align="center"> becomes a
#     <drupal-media> carrying data-view-mode="full" and the preserved data-align="center",
#     with the consumed data-entity-embed-display attribute gone.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  use Drupal\filter\Entity\FilterFormat;

  $format = FilterFormat::load("mdc_task_format");
  if (!$format) { print "FAIL format=missing\n"; return; }
  $coll = $format->filters();
  $legacy = $coll->has("media_directories_legacy_embed") ? $coll->get("media_directories_legacy_embed") : NULL;
  $embed = $coll->has("media_embed") ? $coll->get("media_embed") : NULL;

  $on = $legacy && $legacy->status;
  $order_ok = $on && $embed && $embed->status && ((int) $legacy->weight < (int) $embed->weight);

  $converts = FALSE;
  $processed = "";
  $items = \Drupal::entityTypeManager()->getStorage("media")->loadByProperties(["name" => "MDC task media"]);
  if ($on && $items) {
    $uuid = reset($items)->uuid();
    $html = "<p><drupal-entity data-entity-type=\"media\" data-entity-uuid=\"" . $uuid . "\""
      . " data-entity-embed-display=\"view_mode:media.full\" data-align=\"center\"></drupal-entity></p>";
    $processed = (string) $legacy->process($html, "en")->getProcessedText();
    $converts = str_contains($processed, "<drupal-media")
      && str_contains($processed, "data-view-mode=\"full\"")
      && str_contains($processed, "data-align=\"center\"")
      && !str_contains($processed, "data-entity-embed-display")
      && !str_contains($processed, "<drupal-entity");
  }

  $ok = $on && $order_ok && $converts;
  print ($ok ? "PASS" : "FAIL")
    . " enabled=" . var_export($on, TRUE)
    . " order(legacy<embed)=" . var_export($order_ok, TRUE)
    . " weights=" . ($legacy ? (int) $legacy->weight : "-") . "/" . ($embed ? (int) $embed->weight : "-")
    . " converts=" . var_export($converts, TRUE) . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
