#!/usr/bin/env bash
# Execution VERIFY: PASS when subpathauto.settings has depth === 3 and redirect_support === TRUE.
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("subpathauto.settings");
  $depth = $c->get("depth");
  $redirect = $c->get("redirect_support");
  $ok = ((int) $depth === 3 && $depth !== NULL && (bool) $redirect === TRUE);
  print ($ok ? "PASS" : "FAIL") . " depth=" . var_export($depth, TRUE) . " redirect_support=" . var_export($redirect, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
