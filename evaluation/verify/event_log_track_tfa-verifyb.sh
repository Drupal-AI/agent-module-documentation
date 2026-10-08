#!/usr/bin/env bash
# event_log_track_tfa VERIFY-B: PASS when a 'authentication_tfa' row with ref_char 'ELT_TFA_HB' and operation 'TFA login' exists. Exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $n=(int)\Drupal::database()->select("event_log_track","e")->condition("type","authentication_tfa")->condition("ref_char","ELT_TFA_HB")->condition("operation","TFA login")->countQuery()->execute()->fetchField();
  print ($n>0?"PASS":"FAIL")." count=$n\n";' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
