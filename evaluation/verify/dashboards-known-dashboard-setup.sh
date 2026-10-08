#!/usr/bin/env bash
# Introspection SETUP: create a known dashboard config entity for the agent to read back. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
use Drupal\dashboards\Entity\Dashboard;
if (!\Drupal::entityTypeManager()->getStorage("dashboard")->load("dashboards_probe")) {
  Dashboard::create(["id"=>"dashboards_probe","admin_label"=>"KPI Probe","category"=>"Ops Reporting","weight"=>0,"frontend"=>FALSE,"sections"=>[]])->save();
}
' >/dev/null 2>&1
echo "setup: dashboard dashboards_probe (label 'KPI Probe', category 'Ops Reporting')"
