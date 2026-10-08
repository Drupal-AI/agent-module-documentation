#!/usr/bin/env bash
# Introspection SETUP: create reporting_ep_on (enabled) and reporting_ep_off (disabled). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\reporting\Entity\ReportingEndpoint;
  foreach (["reporting_ep_on", "reporting_ep_off"] as $id) { if ($e = ReportingEndpoint::load($id)) { $e->delete(); } }
  ReportingEndpoint::create(["id" => "reporting_ep_on", "label" => "On", "status" => TRUE])->save();
  ReportingEndpoint::create(["id" => "reporting_ep_off", "label" => "Off", "status" => FALSE])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: reporting_ep_on (enabled), reporting_ep_off (disabled)"
