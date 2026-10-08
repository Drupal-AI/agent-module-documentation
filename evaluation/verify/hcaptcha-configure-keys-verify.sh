#!/usr/bin/env bash
# Execution VERIFY: PASS when hcaptcha.settings has a non-empty site_key AND secret_key AND
# widget.theme === "dark". Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("hcaptcha.settings");
  $sk = (string) $c->get("site_key"); $secret = (string) $c->get("secret_key");
  $theme = (string) $c->get("widget.theme");
  $ok = ($sk !== "" && $secret !== "" && $theme === "dark");
  print ($ok ? "PASS" : "FAIL") . " site_key=" . ($sk !== "" ? "set" : "empty") . " secret_key=" . ($secret !== "" ? "set" : "empty") . " theme=" . var_export($theme, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
