#!/usr/bin/env bash
# Execution RESET (also CLEANUP): delete the dss_eval sitemap type (cascades its variant) and
# any leftover dss_eval variant, so verify FAILS on empty state. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $ts = \Drupal::entityTypeManager()->getStorage("simple_sitemap_type");
  $vs = \Drupal::entityTypeManager()->getStorage("simple_sitemap");
  if ($t = $ts->load("dss_eval")) { $t->delete(); }
  if ($v = $vs->load("dss_eval")) { $v->delete(); }
' >/dev/null 2>&1
echo "reset: removed dss_eval sitemap type and variant"
