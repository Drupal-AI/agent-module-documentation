#!/usr/bin/env bash
# Execution CLEANUP: delete the ai_seo_task report type entity. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $e = \Drupal::entityTypeManager()->getStorage("ai_seo_report_type")->load("ai_seo_task");
  if ($e) { $e->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: ai_seo report type ai_seo_task removed"
