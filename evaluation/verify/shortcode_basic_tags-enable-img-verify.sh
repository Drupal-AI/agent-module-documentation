#!/usr/bin/env bash
# Execution VERIFY for "enable the img tag on sbt_task2". PASS when
# filter.format.sbt_task2 filters.shortcode.status === TRUE AND
# filters.shortcode.settings.img === TRUE. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $config = \Drupal::config("filter.format.sbt_task2");
  $status = $config->get("filters.shortcode.status");
  $img = $config->get("filters.shortcode.settings.img");
  $ok = ($status === TRUE && $img === TRUE);
  print ($ok ? "PASS" : "FAIL") . " status=" . var_export($status, TRUE) . " img=" . var_export($img, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
