#!/usr/bin/env bash
# Execution RESET: remove any consent rows for the task marker service so verify FAILS until the
# agent records one. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::database()->delete("tacjslog")->condition("services_allowed","tacjs_log_task")->execute();' >/dev/null 2>&1
echo "reset: tacjslog cleared of services_allowed=tacjs_log_task"
