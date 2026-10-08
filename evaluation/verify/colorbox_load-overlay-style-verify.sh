#!/usr/bin/env bash
# Execution VERIFY: PASS when the Colorbox overlay is configured with the custom class
# 'cbl-wide', a default width of 960, admin paths NOT skipped, and the drupal_colorbox
# renderer still selected. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("ng_lightbox.settings");
  $class = (string) $c->get("lightbox_class");
  $width = (int) $c->get("default_width");
  $skip  = $c->get("skip_admin_paths");
  $renderer = $c->get("renderer");
  $ok = ($class === "cbl-wide") && ($width === 960) && (!$skip) && ($renderer === "drupal_colorbox");
  print ($ok ? "PASS" : "FAIL") . " class=" . var_export($class, TRUE)
    . " width=" . $width . " skip_admin_paths=" . var_export($skip, TRUE)
    . " renderer=" . var_export($renderer, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
