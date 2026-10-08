#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush cset -y entity_share_websub_subscriber.settings break_subscription_on_edit 0 >/dev/null 2>&1
echo "cleanup: break_subscription_on_edit restored to false"
