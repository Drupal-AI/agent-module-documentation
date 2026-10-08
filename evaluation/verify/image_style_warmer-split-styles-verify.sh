#!/usr/bin/env bash
# Execution VERIFY: PASS when image_style_warmer.settings has 'medium' in initial_image_styles
# AND 'large' in queue_image_styles. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("image_style_warmer.settings");
  $init = (array) $c->get("initial_image_styles");
  $queue = (array) $c->get("queue_image_styles");
  $ok = in_array("medium", $init, TRUE) && in_array("large", $queue, TRUE);
  print ($ok ? "PASS" : "FAIL") . " initial=" . implode(",", array_values($init)) . " queue=" . implode(",", array_values($queue)) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
