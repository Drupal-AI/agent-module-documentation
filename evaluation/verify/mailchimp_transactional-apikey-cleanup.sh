#!/usr/bin/env bash
# Execution CLEANUP: clear api_key and subaccount back to shipped defaults (''). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '$c=\Drupal::configFactory()->getEditable("mailchimp_transactional.settings"); $c->set("api_key", "")->set("subaccount", "")->save();' >/dev/null 2>&1
echo "cleanup: mailchimp_transactional.settings api_key='' subaccount=''"
