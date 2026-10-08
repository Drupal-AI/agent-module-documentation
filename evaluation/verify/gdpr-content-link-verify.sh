#!/usr/bin/env bash
# Execution VERIFY: PASS when gdpr.content_mapping records a non-empty privacy_policy link for
# the default language. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $lang = \Drupal::languageManager()->getDefaultLanguage()->getId();
  $links = \Drupal::config("gdpr.content_mapping")->get("links") ?: [];
  $pp = $links[$lang]["privacy_policy"] ?? "";
  $ok = ($pp !== "" && $pp !== NULL);
  print ($ok ? "PASS" : "FAIL") . " lang=" . $lang . " privacy_policy=" . var_export($pp, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
