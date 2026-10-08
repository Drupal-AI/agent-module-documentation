#!/usr/bin/env bash
# Execution RESET: turn stale-while-revalidate OFF so verify fails until enabled. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '$c=\Drupal::configFactory()->getEditable("fastly.settings"); $c->set("stale_while_revalidate",FALSE); $c->clear("stale_while_revalidate_value"); $c->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: fastly.settings stale_while_revalidate=FALSE"
