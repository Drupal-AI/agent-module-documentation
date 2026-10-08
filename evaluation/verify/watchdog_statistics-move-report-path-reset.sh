#!/usr/bin/env bash
# Execution RESET/CLEANUP: force the watchdog_statistics View page display path back to the
# shipped 'admin/reports/dblog/statistics', so verify (expecting .../stats) FAILS until the
# agent moves it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $cf = \Drupal::configFactory()->getEditable("views.view.watchdog_statistics");
  if ($cf && !$cf->isNew()) {
    $cf->set("display.page.display_options.path", "admin/reports/dblog/statistics")->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: watchdog_statistics page path = admin/reports/dblog/statistics"
