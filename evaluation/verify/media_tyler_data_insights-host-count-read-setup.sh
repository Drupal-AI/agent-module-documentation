#!/usr/bin/env bash
# Introspection SETUP: allow two Data & Insights hosts. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("media_tyler_data_insights.settings")->set("allowed_hosts", ["https://opendata.mdi-eval.com","https://insights.mdi-eval.com"])->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: allowed_hosts=[opendata.mdi-eval.com, insights.mdi-eval.com]"
