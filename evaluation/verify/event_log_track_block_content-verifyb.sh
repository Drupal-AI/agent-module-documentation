#!/usr/bin/env bash
# event_log_track_block_content VERIFY-B: PASS when a 'block_content' row with ref_char 'ELT_BLOCK_HB' and operation 'delete' exists. Exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $n=(int)\Drupal::database()->select("event_log_track","e")->condition("type","block_content")->condition("ref_char","ELT_BLOCK_HB")->condition("operation","delete")->countQuery()->execute()->fetchField();
  print ($n>0?"PASS":"FAIL")." count=$n\n";' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
