#!/usr/bin/env bash
# Introspection CLEANUP: clear the webform_analysis third-party settings on wanalysis_fixture
# (restore baseline: no analysis config). Leaves the fixture webform in place. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $w = \Drupal::entityTypeManager()->getStorage("webform")->load("wanalysis_fixture");
  if ($w) {
    $w->unsetThirdPartySetting("webform_analysis", "chart_type");
    $w->unsetThirdPartySetting("webform_analysis", "components");
    $w->unsetThirdPartySetting("webform_analysis", "in_draft");
    $w->save();
  }
' >/dev/null 2>&1
echo "cleanup: wanalysis_fixture webform_analysis settings cleared"
