#!/usr/bin/env bash
# Execution RESET: remove any previously scaffolded ebt_skprobe module directory so verify FAILS
# (files absent) until the agent runs the generator. The module is never enabled, so no pmu is
# needed. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
rm -rf web/modules/custom/ebt_skprobe
echo "reset: web/modules/custom/ebt_skprobe removed"
