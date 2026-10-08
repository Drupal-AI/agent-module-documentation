#!/usr/bin/env bash
# Execution VERIFY (modal_page H2): PASS when modal_page.settings has bootstrap_version '5x' AND
# default_cookie_expiration 3600. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("modal_page.settings");
  $bv = $c->get("bootstrap_version");
  $ce = (int) $c->get("default_cookie_expiration");
  $ok = ($bv === "5x") && ($ce === 3600);
  print ($ok ? "PASS" : "FAIL")." bootstrap_version=".var_export($bv,TRUE)." default_cookie_expiration=".$ce."\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
