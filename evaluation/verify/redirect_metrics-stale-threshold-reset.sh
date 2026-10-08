#!/usr/bin/env bash
# Execution RESET/CLEANUP for the stale-threshold case: force the redirect_metrics View's
# page_2 (Stale redirects) last_access filter back to the shipped '-6 months' offset, so the
# verify (which expects '-3 months') FAILS until the agent changes it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $cf = \Drupal::configFactory()->getEditable("views.view.redirect_metrics");
  if ($cf && !$cf->isNew()) {
    $val = $cf->get("display.page_2.display_options.filters.last_access.value");
    if (is_array($val)) {
      $val["value"] = "-6 months";
      $cf->set("display.page_2.display_options.filters.last_access.value", $val)->save();
    }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: redirect_metrics page_2 last_access filter = -6 months"
