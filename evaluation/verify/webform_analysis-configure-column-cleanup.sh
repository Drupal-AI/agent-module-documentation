#!/usr/bin/env bash
# Execution CLEANUP: clear webform_analysis settings on wanalysis_fixture. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $w = \Drupal::entityTypeManager()->getStorage("webform")->load("wanalysis_fixture");
  if ($w) { $w->unsetThirdPartySetting("webform_analysis", "chart_type"); $w->unsetThirdPartySetting("webform_analysis", "components"); $w->save(); }
' >/dev/null 2>&1
echo "cleanup: wanalysis_fixture webform_analysis settings cleared"
