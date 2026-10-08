#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush cset -y entity_share_websub_subscriber.settings cancel_title 'Do you want to cancel subscription?' >/dev/null 2>&1
echo "cleanup: cancel_title restored to shipped default"
