#!/usr/bin/env bash
# next_jwt execution VERIFY: PASS when preview_url_generator === 'jwt' AND
# preview_url_generator_configuration.secret_expiration === 60. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $cfg = \Drupal::config("next.settings");
  $gen = $cfg->get("preview_url_generator");
  $exp = $cfg->get("preview_url_generator_configuration.secret_expiration");
  $ok = ($gen === "jwt") && ((int) $exp === 60);
  print ($ok ? "PASS" : "FAIL") . " generator=" . var_export($gen, TRUE) . " secret_expiration=" . var_export($exp, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
