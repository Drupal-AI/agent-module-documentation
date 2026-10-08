#!/usr/bin/env bash
# Introspection CLEANUP: re-enable the shipped 'link_analysis' report type. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $e = \Drupal::entityTypeManager()->getStorage("ai_seo_report_type")->load("link_analysis");
  if ($e) { $e->set("status", TRUE)->save(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: ai_seo report type link_analysis re-enabled (status=TRUE)"
