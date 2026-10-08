#!/usr/bin/env bash
# Execution VERIFY: PASS when codemirror_editor.settings has cdn === false AND minified === false
# (self-hosted, un-minified). Pure config read. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("codemirror_editor.settings");
  $cdn = $c->get("cdn"); $min = $c->get("minified");
  $ok = ($cdn === FALSE && $min === FALSE);
  print (($ok) ? "PASS" : "FAIL") . " cdn=" . var_export($cdn, TRUE) . " minified=" . var_export($min, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
