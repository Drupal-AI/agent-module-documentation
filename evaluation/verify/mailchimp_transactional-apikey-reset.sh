#!/usr/bin/env bash
# Execution RESET: clear api_key and subaccount (shipped defaults ''), so verify FAILS until the
# agent sets them. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '$c=\Drupal::configFactory()->getEditable("mailchimp_transactional.settings"); $c->set("api_key", "")->set("subaccount", "")->save();' >/dev/null 2>&1
echo "reset: mailchimp_transactional.settings api_key='' subaccount=''"
