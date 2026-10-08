#!/usr/bin/env bash
# Execution VERIFY: PASS when entity_share_websub_hub is enabled. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
if drush pm:list --status=enabled --field=name 2>/dev/null | grep -qx entity_share_websub_hub; then
  echo "PASS entity_share_websub_hub enabled"; exit 0
else
  echo "FAIL entity_share_websub_hub not enabled"; exit 1
fi
