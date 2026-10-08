#!/usr/bin/env bash
# Execution VERIFY: PASS when Persistent Login is configured for a 90-day lifetime measured
# from last use, a maximum of 5 remembered logins per user, and the checkbox label
# "Stay signed in". Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("persistent_login.settings");
  $lifetime = (int) $c->get("lifetime");
  $extend = $c->get("extend_lifetime");
  $max = (int) $c->get("max_tokens");
  $label = (string) $c->get("login_form.field_label");
  $ok = ($lifetime === 90) && ($extend == TRUE) && ($max === 5) && ($label === "Stay signed in");
  print ($ok ? "PASS" : "FAIL") . " lifetime=" . $lifetime
    . " extend_lifetime=" . var_export($extend, TRUE)
    . " max_tokens=" . $max . " label=" . var_export($label, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
