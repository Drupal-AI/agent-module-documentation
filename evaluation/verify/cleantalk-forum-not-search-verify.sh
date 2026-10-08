#!/usr/bin/env bash
# HARD live-state verification (config only — no network / no live spam check):
# requires cleantalk.settings to have a non-empty Access key, forum-topic protection ON,
# and search-form checking OFF. Prints PASS/FAIL; exits 0 (pass) / 1 (fail). No arguments.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $c   = \Drupal::config("cleantalk.settings");
  $key = (string) $c->get("cleantalk_authkey");
  $ft  = $c->get("cleantalk_check_forum_topics");
  $sf  = $c->get("cleantalk_check_search_form");
  $ok  = ($key !== "" && $ft == TRUE && $sf == FALSE);
  print ($ok ? "PASS" : "FAIL")
    . " key=" . ($key !== "" ? "set" : "empty")
    . " forum_topics=" . var_export($ft, TRUE)
    . " search_form=" . var_export($sf, TRUE) . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
