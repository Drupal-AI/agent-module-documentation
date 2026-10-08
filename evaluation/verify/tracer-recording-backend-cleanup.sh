#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
rm -rf web/modules/custom/trcr_recorder
echo "cleanup: web/modules/custom/trcr_recorder removed"
