#!/usr/bin/env bash
# Introspection SETUP: disable the shipped 'link_analysis' report type (status=FALSE) so an
# inspecting agent can report which report type is currently disabled. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $e = \Drupal::entityTypeManager()->getStorage("ai_seo_report_type")->load("link_analysis");
  if ($e) { $e->set("status", FALSE)->save(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: ai_seo report type link_analysis disabled (status=FALSE)"
