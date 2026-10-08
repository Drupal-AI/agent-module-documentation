#!/usr/bin/env bash
# Execution VERIFY: PASS when the warning-modal title is exactly "Your session is about to expire"
# AND the modal text still contains the @count countdown placeholder. Prints PASS/FAIL; exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("inactive_autologout.settings");
  $t = (string) $c->get("modal_title");
  $x = (string) $c->get("modal_text");
  $ok = ($t === "Your session is about to expire" && strpos($x, "@count") !== FALSE);
  print ($ok ? "PASS" : "FAIL") . " modal_title=" . var_export($t, TRUE) . " has_count=" . var_export(strpos($x, "@count") !== FALSE, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
