#!/usr/bin/env bash
# Introspection CLEANUP: delete reporting_ep_on and reporting_ep_off. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\reporting\Entity\ReportingEndpoint;
  foreach (["reporting_ep_on", "reporting_ep_off"] as $id) { if ($e = ReportingEndpoint::load($id)) { $e->delete(); } }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: reporting_ep_on/off removed"
