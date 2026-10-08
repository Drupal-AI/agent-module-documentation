#!/usr/bin/env bash
# Execution VERIFY: PASS when bootstrap_library.settings restricts loading to the listed
# pages only (url.visibility == 1) AND the list contains both /bl-eval-landing and
# /bl-eval-landing/*. Leading slashes are optional (the module lowercases and path-matches).
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("bootstrap_library.settings");
  $vis = $c->get("url.visibility");
  $pages = $c->get("url.pages");
  if (is_string($pages)) { $pages = preg_split("/\r\n|\r|\n/", $pages); }
  $norm = array_map(function ($p) { return strtolower(ltrim(trim((string) $p), "/")); }, (array) $pages);
  $ok = ((int) $vis === 1)
    && in_array("bl-eval-landing", $norm, TRUE)
    && in_array("bl-eval-landing/*", $norm, TRUE);
  print ($ok ? "PASS" : "FAIL") . " url.visibility=" . var_export($vis, TRUE)
    . " pages=" . implode(",", $norm) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
