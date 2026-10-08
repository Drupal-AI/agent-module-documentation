#!/usr/bin/env bash
# Live-state verification for the "create the eval_signup message template" task.
# PASS if a message_template config entity `eval_signup` exists, is enabled, and has at
# least one text partial whose value contains the token [message:author:name].
# Prints PASS/FAIL with detail; exits 0 (pass) / 1 (fail). No arguments.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $t = \Drupal::entityTypeManager()->getStorage("message_template")->load("eval_signup");
  $exists = (bool) $t;
  $enabled = $exists && $t->status();
  $tok = FALSE;
  if ($exists) {
    foreach ($t->getRawText() as $partial) {
      $v = is_array($partial) ? ($partial["value"] ?? "") : (string) $partial;
      if (stripos($v, "[message:author:name]") !== FALSE) { $tok = TRUE; }
    }
  }
  print (($exists && $enabled && $tok) ? "PASS" : "FAIL")
    . " exists=" . ($exists?1:0) . " enabled=" . ($enabled?1:0) . " token=" . ($tok?1:0) . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
