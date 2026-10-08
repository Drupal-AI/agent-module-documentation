#!/usr/bin/env bash
# Execution VERIFY: PASS when the sf_task Swiper template exists with swiper_options.direction
# == vertical and swiper_options.autoplay.enabled === true. Prints PASS/FAIL; exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("swiper_formatter.swiper_formatter.sf_task");
  $id = $c->get("id");
  $dir = $c->get("swiper_options.direction");
  $ap = $c->get("swiper_options.autoplay.enabled");
  $ok = ($id === "sf_task" && $dir === "vertical" && $ap === TRUE);
  print ($ok ? "PASS" : "FAIL") . " id=" . var_export($id, TRUE) . " dir=" . var_export($dir, TRUE) . " autoplay=" . var_export($ap, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
