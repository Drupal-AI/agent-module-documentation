#!/usr/bin/env bash
# Execution VERIFY for "enable the shortcode filter + the quote tag on sbt_task". PASS when
# filter.format.sbt_task filters.shortcode.status === TRUE AND
# filters.shortcode.settings.quote === TRUE. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $config = \Drupal::config("filter.format.sbt_task");
  $status = $config->get("filters.shortcode.status");
  $quote = $config->get("filters.shortcode.settings.quote");
  $ok = ($status === TRUE && $quote === TRUE);
  print ($ok ? "PASS" : "FAIL") . " status=" . var_export($status, TRUE) . " quote=" . var_export($quote, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
