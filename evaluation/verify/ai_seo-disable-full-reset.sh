#!/usr/bin/env bash
# Execution RESET: ensure the shipped 'topic_authority' report type is ENABLED (status TRUE),
# so verify FAILS until the agent disables it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $e = \Drupal::entityTypeManager()->getStorage("ai_seo_report_type")->load("topic_authority");
  if ($e) { $e->set("status", TRUE)->save(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: ai_seo report type topic_authority enabled (status=TRUE)"
