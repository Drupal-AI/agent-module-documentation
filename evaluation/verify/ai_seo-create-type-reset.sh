#!/usr/bin/env bash
# Execution RESET: ensure NO ai_seo_report_type entity 'ai_seo_task' exists, so verify FAILS
# until the agent creates it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $e = \Drupal::entityTypeManager()->getStorage("ai_seo_report_type")->load("ai_seo_task");
  if ($e) { $e->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: ai_seo report type ai_seo_task absent"
