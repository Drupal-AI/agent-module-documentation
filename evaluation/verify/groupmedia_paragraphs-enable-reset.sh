#!/usr/bin/env bash
# Execution RESET: uninstall groupmedia_paragraphs so its finders are NOT registered and verify
# FAILS until the agent enables the submodule. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pmu groupmedia_paragraphs -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: groupmedia_paragraphs uninstalled"
