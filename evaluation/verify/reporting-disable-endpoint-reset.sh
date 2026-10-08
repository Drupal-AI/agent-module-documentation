#!/usr/bin/env bash
# Execution RESET: (re)create reporting_ep_toggle ENABLED so verify FAILS until the agent disables it.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\reporting\Entity\ReportingEndpoint;
  if ($e = ReportingEndpoint::load("reporting_ep_toggle")) { $e->delete(); }
  ReportingEndpoint::create(["id" => "reporting_ep_toggle", "label" => "Toggle", "status" => TRUE])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: reporting_ep_toggle present and ENABLED"
