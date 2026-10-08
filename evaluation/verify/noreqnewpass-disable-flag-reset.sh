#!/usr/bin/env bash
# Execution RESET for the "disable the password-reset flow" task: force
# noreqnewpass.settings_form:noreqnewpass_disable to FALSE (baseline) so the /user/password
# route is reachable and verify FAILs until the agent enables the flag. Rebuilds routes.
# Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("noreqnewpass.settings_form")
    ->set("noreqnewpass_disable", FALSE)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: noreqnewpass_disable = FALSE (password-reset route reachable)"
