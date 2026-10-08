#!/usr/bin/env bash
# Execution VERIFY: PASS when webform wsw_test has a handler with plugin id
# 'webform_spam_words', its settings.spam_field_name includes 'message', and
# settings.spam_words is a non-empty array of at least one non-empty word (a bare string
# is a no-op due to the module's foreach-on-scalar bug in defaultConfiguration()).
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\webform\Entity\Webform;
  $w = Webform::load("wsw_test");
  $handlers = $w ? $w->get("handlers") : [];
  $found = NULL;
  foreach ((array) $handlers as $h) {
    if (($h["id"] ?? NULL) === "webform_spam_words") { $found = $h; break; }
  }
  $settings = $found["settings"] ?? [];
  $words = $settings["spam_words"] ?? NULL;
  $field = (string) ($settings["spam_field_name"] ?? "");
  $fields = array_map("trim", explode(",", $field));
  $has_message_field = in_array("message", $fields, TRUE);
  $has_words = is_array($words) && count(array_filter($words, function ($x) { return trim((string) $x) !== ""; })) > 0;
  $ok = (bool) $found && $has_message_field && $has_words;
  print ($ok ? "PASS" : "FAIL") . " handler=" . ($found ? "present" : "absent") . " field=" . $field . " words=" . (is_array($words) ? implode(",", $words) : var_export($words, TRUE)) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
