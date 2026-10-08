#!/usr/bin/env bash
# Execution CLEANUP: remove the scaffolded ebt_skprobe module directory. The module is not
# enabled (pure files), so a simple directory removal is safe. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
rm -rf web/modules/custom/ebt_skprobe
echo "cleanup: web/modules/custom/ebt_skprobe removed"
