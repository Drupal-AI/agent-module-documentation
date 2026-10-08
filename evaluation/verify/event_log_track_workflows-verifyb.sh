#!/usr/bin/env bash
# event_log_track_workflows VERIFY-B: PASS when a 'workflows' row with ref_char 'ELT_WORKFLOW_HB' and operation 'update' exists. Exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $n=(int)\Drupal::database()->select("event_log_track","e")->condition("type","workflows")->condition("ref_char","ELT_WORKFLOW_HB")->condition("operation","update")->countQuery()->execute()->fetchField();
  print ($n>0?"PASS":"FAIL")." count=$n\n";' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
