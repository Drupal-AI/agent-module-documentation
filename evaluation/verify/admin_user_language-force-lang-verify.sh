#!/usr/bin/env bash
# Execution VERIFY: PASS when the module is configured to force English (en) on users and prevent
# override: default_language_to_assign === 'en' AND prevent_user_override === TRUE.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("admin_user_language.settings");
  $lang = $c->get("default_language_to_assign");
  $prev = $c->get("prevent_user_override");
  $ok = ($lang === "en" && $prev === TRUE);
  print ($ok ? "PASS" : "FAIL") . " lang=" . var_export($lang, TRUE) . " prevent=" . var_export($prev, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
