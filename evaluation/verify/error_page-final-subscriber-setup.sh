#!/usr/bin/env bash
# Introspection SETUP (error_page M2): rebuild the container so error_page's registered event
# subscriber service is present. The agent must inspect the live container to identify the
# service error_page adds to render the friendly exception page. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cr >/dev/null 2>&1
echo "setup: container rebuilt; error_page.exception_subscriber registered"
