#!/usr/bin/env bash
# Execution VERIFY (demo): PASS when State email_attachment_demo_eval.result holds a message the
# email_attachment module turned into multipart/mixed with the email_attachment_demo.module file
# attached (as the demo does for contact_page_mail). Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $m = \Drupal::state()->get("email_attachment_demo_eval.result");
  $ct = is_array($m) ? ($m["headers"]["Content-Type"] ?? "") : "";
  $body = is_array($m) ? (is_array($m["body"] ?? NULL) ? implode("", $m["body"]) : (string) ($m["body"] ?? "")) : "";
  $ok = is_array($m)
    && str_contains($ct, "multipart/mixed")
    && str_contains($body, "Content-Disposition: attachment")
    && str_contains($body, "email_attachment_demo.module");
  print ($ok ? "PASS" : "FAIL") . " content_type=" . var_export($ct, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
