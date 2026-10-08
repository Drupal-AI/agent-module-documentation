#!/usr/bin/env bash
# Introspection SETUP: create enabled reporting_endpoint 'reporting_ep_known'. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\reporting\Entity\ReportingEndpoint;
  if ($e = ReportingEndpoint::load("reporting_ep_known")) { $e->delete(); }
  ReportingEndpoint::create(["id" => "reporting_ep_known", "label" => "Known CSP Collector", "status" => TRUE])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: reporting_ep_known created (enabled)"
