#!/usr/bin/env bash
# Introspection SETUP: store known boolean flags in a config object (dbug.eval_flags) so an
# agent can dump them with dbug and report how dbug renders a TRUE boolean. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("dbug.eval_flags")
    ->setData(["enabled" => TRUE, "disabled" => FALSE])
    ->save();
' >/dev/null 2>&1
echo "setup: config dbug.eval_flags = {enabled: TRUE, disabled: FALSE}"
