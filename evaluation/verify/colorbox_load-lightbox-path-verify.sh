#!/usr/bin/env bash
# Execution VERIFY: PASS when ng_lightbox.settings selects the colorbox_load renderer
# (drupal_colorbox) AND a path pattern covering /cbl-task is configured.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("ng_lightbox.settings");
  $renderer = $c->get("renderer");
  $patterns = (string) $c->get("patterns");
  $hasPath = (bool) preg_match("#(^|\n)\s*/cbl-task#", $patterns);
  $ok = ($renderer === "drupal_colorbox") && $hasPath;
  print ($ok ? "PASS" : "FAIL") . " renderer=" . var_export($renderer, TRUE)
    . " patterns=" . var_export($patterns, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
