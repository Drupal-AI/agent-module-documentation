#!/usr/bin/env bash
# Execution CLEANUP: delete pipeline imageapi_bin_evald and restore default_pipeline to null.
set -uo pipefail
cd /var/www/html
drush php:eval 'if ($p = \Drupal::entityTypeManager()->getStorage("imageapi_optimize_pipeline")->load("imageapi_bin_evald")) { $p->delete(); }' >/dev/null 2>&1
drush php:eval '\Drupal::configFactory()->getEditable("imageapi_optimize.settings")->set("default_pipeline", NULL)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: pipeline imageapi_bin_evald removed, default_pipeline=null"
