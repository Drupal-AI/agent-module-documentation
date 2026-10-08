#!/usr/bin/env bash
# Introspection SETUP: set Mailgun tracking_opens to 'yes' (baseline default is '') so an
# inspecting agent can read the open-tracking setting. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset mailgun.settings tracking_opens yes -y >/dev/null 2>&1
echo "setup: mailgun.settings tracking_opens=yes"
