#!/usr/bin/env bash
# Execution VERIFY: PASS when State email_attachment_demo_eval.result holds a message that the
# email_attachment module turned into multipart/mixed, carrying the demo's hook source file
# (attachment named EmailAttachmentDemoHooks.php) for a contact_page_mail message. This mirrors
# what the (un-enableable) email_attachment_demo submodule does. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $m = \Drupal::state()->get("email_attachment_demo_eval.result");
  $ct = is_array($m) ? ($m["headers"]["Content-Type"] ?? "") : "";
  $body = is_array($m) ? (is_array($m["body"] ?? NULL) ? implode("", $m["body"]) : (string) ($m["body"] ?? "")) : "";
  $id_ok = is_array($m) ? (($m["id"] ?? "") === "contact_page_mail") : FALSE;
  $ok = is_array($m)
    && $id_ok
    && str_contains($ct, "multipart/mixed")
    && str_contains($body, "Content-Disposition: attachment")
    && str_contains($body, "EmailAttachmentDemoHooks.php");
  print ($ok ? "PASS" : "FAIL") . " id=" . var_export(is_array($m) ? ($m["id"] ?? NULL) : NULL, TRUE)
    . " content_type=" . var_export($ct, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
