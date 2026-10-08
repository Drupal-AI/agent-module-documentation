#!/usr/bin/env bash
# Execution VERIFY for "enable both url_embed filters on the url_embed_task text format".
# PASS when filter.format.url_embed_task has both url_embed_convert_links and url_embed
# filters with status === TRUE. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  $format = FilterFormat::load("url_embed_task");
  $convert = $format ? $format->filters()->get("url_embed_convert_links") : NULL;
  $render = $format ? $format->filters()->get("url_embed") : NULL;
  $convert_on = $convert ? (bool) $convert->status : FALSE;
  $render_on = $render ? (bool) $render->status : FALSE;
  $ok = $convert_on && $render_on;
  print ($ok ? "PASS" : "FAIL") . " convert_links=" . var_export($convert_on, TRUE) . " url_embed=" . var_export($render_on, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
