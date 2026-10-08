#!/usr/bin/env bash
# Execution VERIFY: PASS when bootstrap_library is set to load the LOCAL non-minified/source
# build (cdn.bootstrap falsy AND minimized.options == 0) and only for the Olivero theme
# (theme.visibility == 1 and theme.themes contains olivero). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("bootstrap_library.settings");
  $min = $c->get("minimized.options");
  $cdn = $c->get("cdn.bootstrap");
  $vis = $c->get("theme.visibility");
  $themes = $c->get("theme.themes");
  $themeList = is_array($themes) ? array_values(array_filter($themes)) : array_filter([$themes]);
  $ok = ((int) $min === 0)
    && empty($cdn)
    && ((int) $vis === 1)
    && in_array("olivero", $themeList, TRUE);
  print ($ok ? "PASS" : "FAIL") . " minimized.options=" . var_export($min, TRUE)
    . " cdn.bootstrap=" . var_export($cdn, TRUE)
    . " theme.visibility=" . var_export($vis, TRUE)
    . " theme.themes=" . implode(",", $themeList) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
