#!/usr/bin/env bash
# Introspection CLEANUP: restore Mailgun tracking_opens to shipped default '' (use domain setting). Exit 0.
set -uo pipefail
cd /var/www/html
drush cset mailgun.settings tracking_opens '' -y >/dev/null 2>&1
echo "cleanup: mailgun.settings tracking_opens='' (default restored)"
