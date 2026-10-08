#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c=\Drupal::config("restrict_ip.settings");
  $m=$c->get("mail_address"); $d=$c->get("dblog");
  $ok=($m==="ripcontact@example.com" && $d===TRUE);
  print ($ok?"PASS":"FAIL")." mail=".var_export($m,TRUE)." dblog=".var_export($d,TRUE)."\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
