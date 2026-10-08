#!/usr/bin/env bash
# Execution VERIFY: PASS when recaptcha_type === v3 and v3_score === 75. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("simple_recaptcha.config");
  $t = $c->get("recaptcha_type"); $s = (int) $c->get("v3_score");
  $ok = ($t === "v3" && $s === 75);
  print ($ok ? "PASS" : "FAIL") . " type=" . var_export($t, TRUE) . " score=" . $s . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
