#!/usr/bin/env bash
# Execution VERIFY for "enable inline image resizing on mdir_enable_format".
# PASS when on the live filter.format.mdir_enable_format:
#   * media_directories_image_resize is enabled,
#   * its weight is HIGHER than media_embed's (the filter description says place it AFTER
#     filters that may add images),
#   * and it really rewrites markup: processing an <img> of banner.png at 100x80 changes the
#     src to the /resize/100x80/mdir-enable/banner.png derivative.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  use Drupal\filter\Entity\FilterFormat;

  $format = FilterFormat::load("mdir_enable_format");
  if (!$format) { print "FAIL format=missing\n"; return; }

  $coll = $format->filters();
  $resize = $coll->has("media_directories_image_resize") ? $coll->get("media_directories_image_resize") : NULL;
  $embed = $coll->has("media_embed") ? $coll->get("media_embed") : NULL;

  $on = $resize && $resize->status;
  $order_ok = $on && $embed && $embed->status && ((int) $resize->weight > (int) $embed->weight);

  $rewrites = FALSE;
  $out_html = "";
  if ($on) {
    $base = \Drupal::service("stream_wrapper_manager")->getViaScheme("public")->getDirectoryPath();
    $html = "<p><img src=\"/" . $base . "/mdir-enable/banner.png\" width=\"100\" height=\"80\" alt=\"b\" /></p>";
    $out_html = (string) $resize->process($html, "en")->getProcessedText();
    $rewrites = str_contains($out_html, "/resize/100x80/mdir-enable/banner.png");
  }

  $ok = $on && $order_ok && $rewrites;
  print ($ok ? "PASS" : "FAIL")
    . " enabled=" . var_export($on, TRUE)
    . " order(resize>embed)=" . var_export($order_ok, TRUE)
    . " weights=" . ($resize ? (int) $resize->weight : "-") . "/" . ($embed ? (int) $embed->weight : "-")
    . " rewrites_src=" . var_export($rewrites, TRUE) . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
