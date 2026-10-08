#!/usr/bin/env bash
# Execution RESET: uninstall twig_tools so verify FAILS until the agent installs it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pmu twig_tools -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: twig_tools uninstalled"
