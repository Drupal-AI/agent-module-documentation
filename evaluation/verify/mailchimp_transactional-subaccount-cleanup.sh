#!/usr/bin/env bash
# Introspection CLEANUP: restore subaccount to its shipped default (empty string). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush config:set mailchimp_transactional.settings subaccount '' -y >/dev/null 2>&1
echo "cleanup: mailchimp_transactional.settings subaccount restored to ''"
