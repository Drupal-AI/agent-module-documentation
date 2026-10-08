#!/usr/bin/env bash
# Execution VERIFY: PASS when State email_attachment_eval.result2 is a multipart/mixed message
# carrying BOTH attachments a.txt (AAA -> QUFB) and b.txt (BBB -> QkJC). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $m=\Drupal::state()->get("email_attachment_eval.result2");
  $ct=is_array($m)?($m["headers"]["Content-Type"]??""):"";
  $body=is_array($m)?(is_array($m["body"]??NULL)?implode("",$m["body"]):(string)($m["body"]??"")):"";
  $ok=is_array($m)&&str_contains($ct,"multipart/mixed")
    &&str_contains($body,"a.txt")&&str_contains($body,"QUFB")
    &&str_contains($body,"b.txt")&&str_contains($body,"QkJC");
  print ($ok?"PASS":"FAIL")." content_type=".var_export($ct,TRUE)."\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
