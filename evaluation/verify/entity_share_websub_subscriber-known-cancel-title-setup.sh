#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush cset -y entity_share_websub_subscriber.settings cancel_title 'ESW Cancel Now?' >/dev/null 2>&1
echo "setup: cancel_title=ESW Cancel Now?"
