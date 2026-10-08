#!/usr/bin/env bash
# Execution CLEANUP: identical teardown to the reset - removes the mr_task media type, its
# fields, displays and any orphaned field storage. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
bash agent-module-documentation/evaluation/verify/media_remote-loom-type-reset.sh >/dev/null 2>&1
echo "cleanup: media type mr_task and its fields removed"
