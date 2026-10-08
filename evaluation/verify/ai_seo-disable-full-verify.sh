#!/usr/bin/env bash
# Execution VERIFY: PASS when the shipped 'topic_authority' report type is DISABLED
# (status === FALSE). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $e = \Drupal::entityTypeManager()->getStorage("ai_seo_report_type")->load("topic_authority");
  $status = $e ? (bool) $e->get("status") : TRUE;
  $ok = $e && ($status === FALSE);
  print ($ok ? "PASS" : "FAIL") . " exists=" . var_export((bool) $e, TRUE) . " status=" . var_export($status, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
