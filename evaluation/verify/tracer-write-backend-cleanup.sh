#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
rm -rf web/modules/custom/trcr_backend
echo "cleanup: web/modules/custom/trcr_backend removed"
