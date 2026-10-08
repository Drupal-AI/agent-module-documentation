#!/usr/bin/env bash
# HARD live-state verification (config only — no network / no live spam check):
# requires cleantalk.settings to have a non-empty Access key AND comment + user-registration
# protection turned on. Prints PASS/FAIL; exits 0 (pass) / 1 (fail). No arguments.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $c   = \Drupal::config("cleantalk.settings");
  $key = (string) $c->get("cleantalk_authkey");
  $cm  = $c->get("cleantalk_check_comments");
  $rg  = $c->get("cleantalk_check_register");
  $ok  = ($key !== "" && $cm == TRUE && $rg == TRUE);
  print ($ok ? "PASS" : "FAIL")
    . " key=" . ($key !== "" ? "set" : "empty")
    . " comments=" . var_export($cm, TRUE)
    . " register=" . var_export($rg, TRUE) . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
