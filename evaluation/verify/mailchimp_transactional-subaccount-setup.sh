#!/usr/bin/env bash
# Introspection SETUP: set mailchimp_transactional.settings:subaccount to a known value so an
# inspecting agent can read it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush config:set mailchimp_transactional.settings subaccount mtx_news -y >/dev/null 2>&1
echo "setup: mailchimp_transactional.settings subaccount = mtx_news"
