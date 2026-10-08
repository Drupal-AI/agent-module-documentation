#!/usr/bin/env bash
# Introspection SETUP: set a known ide opener on webprofiler settings so an agent can read it
# back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset -y webprofiler.settings ide 'vscode://file/%f:%l' >/dev/null 2>&1
echo "setup: webprofiler.settings ide=vscode://file/%f:%l"
