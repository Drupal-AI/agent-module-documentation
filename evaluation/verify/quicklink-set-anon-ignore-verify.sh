#!/usr/bin/env bash
# Execution VERIFY: PASS when quicklink.settings has no_load_when_authenticated===TRUE and
# url_patterns_to_ignore contains 'qlk_block_me'. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("quicklink.settings");
  $anon = $c->get("no_load_when_authenticated");
  $pat = (string) $c->get("url_patterns_to_ignore");
  $ok = ($anon === TRUE && strpos($pat, "qlk_block_me") !== FALSE);
  print ($ok ? "PASS" : "FAIL") . " anon=" . var_export($anon, TRUE) . " patterns=" . var_export($pat, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
