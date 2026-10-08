#!/usr/bin/env bash
# Introspection SETUP: allow a single Data & Insights host. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("media_tyler_data_insights.settings")->set("allowed_hosts", ["https://data.mdi-eval.gov"])->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: allowed_hosts=[https://data.mdi-eval.gov]"
