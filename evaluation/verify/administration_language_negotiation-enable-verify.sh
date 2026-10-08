#!/usr/bin/env bash
# Execution VERIFY: PASS when the administration-language-negotiation method is enabled for the
# interface language type (its key exists under language.types
# negotiation.language_interface.enabled). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $en = \Drupal::config("language.types")->get("negotiation.language_interface.enabled") ?: [];
  $ok = array_key_exists("administration-language-negotiation", $en);
  print ($ok ? "PASS" : "FAIL") . " enabled=" . implode(",", array_keys($en)) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
