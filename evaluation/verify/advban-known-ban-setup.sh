#!/usr/bin/env bash
# Introspection SETUP: ban a known documentation-range IP (203.0.113.45) through the
# advban.ip_manager service with a distinctive reason, so an inspecting agent can read the
# reason back out of the advban_ip table. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $m = \Drupal::service("advban.ip_manager");
  $m->unbanIp("203.0.113.45");
  $m->banIp("203.0.113.45", "", "advban-eval: scraping incident 4711", strtotime("+30 days"));
' >/dev/null 2>&1
echo "setup: 203.0.113.45 banned with reason 'advban-eval: scraping incident 4711'"
