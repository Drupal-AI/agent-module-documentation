#!/usr/bin/env bash
# Execution RESET: remove pipeline "imageapi_bin_evald" and force imageapi_optimize.settings
# default_pipeline back to its shipped default (null), so verify FAILS until the agent builds it.
set -uo pipefail
cd /var/www/html
drush php:eval 'if ($p = \Drupal::entityTypeManager()->getStorage("imageapi_optimize_pipeline")->load("imageapi_bin_evald")) { $p->delete(); }' >/dev/null 2>&1
drush php:eval '\Drupal::configFactory()->getEditable("imageapi_optimize.settings")->set("default_pipeline", NULL)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: pipeline imageapi_bin_evald absent, default_pipeline=null"
