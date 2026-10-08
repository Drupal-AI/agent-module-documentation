#!/usr/bin/env bash
# Execution CLEANUP: re-enable the shipped 'topic_authority' report type (status TRUE). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $e = \Drupal::entityTypeManager()->getStorage("ai_seo_report_type")->load("topic_authority");
  if ($e) { $e->set("status", TRUE)->save(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: ai_seo report type topic_authority re-enabled (status=TRUE)"
