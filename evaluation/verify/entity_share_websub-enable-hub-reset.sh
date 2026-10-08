#!/usr/bin/env bash
# Execution RESET: uninstall the publisher submodule so verify FAILS until the agent enables
# it. Leaves the base module and subscriber intact. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pmu entity_share_websub_hub -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: entity_share_websub_hub uninstalled"
