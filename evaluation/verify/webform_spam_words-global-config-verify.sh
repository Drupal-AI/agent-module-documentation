#!/usr/bin/env bash
# Execution VERIFY: PASS when webform_spam_words.settings has spam_words containing
# 'viagra' (case-insensitive) AND spam_field_name === 'email'. Prints PASS/FAIL;
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $config = \Drupal::config("webform_spam_words.settings");
  $words = $config->get("spam_words") ?: [];
  $field = (string) ($config->get("spam_field_name") ?? "");
  $has_viagra = FALSE;
  foreach ((array) $words as $w) {
    if (mb_strtolower(trim((string) $w)) === "viagra") { $has_viagra = TRUE; }
  }
  $ok = $has_viagra && trim($field) === "email";
  print ($ok ? "PASS" : "FAIL") . " spam_field_name=" . $field . " spam_words=" . implode(",", (array) $words) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
