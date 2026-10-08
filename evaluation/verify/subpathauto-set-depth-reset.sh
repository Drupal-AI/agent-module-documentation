#!/usr/bin/env bash
# Execution RESET: force subpathauto to a depth the task does not want (1) so verify fails
# until the agent changes it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("subpathauto.settings")
    ->set("depth", 1)
    ->set("redirect_support", FALSE)
    ->save();
' >/dev/null 2>&1
echo "reset: subpathauto.settings depth=1 redirect_support=FALSE"
