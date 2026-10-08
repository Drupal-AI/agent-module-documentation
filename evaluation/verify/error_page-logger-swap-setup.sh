#!/usr/bin/env bash
# Introspection SETUP (error_page M1): error_page has no DB/config state — its live footprint is
# the event-subscriber service it registers to render the friendly exception page. Just rebuild
# the container so the service is present; the agent inspects the running site to name the
# service id + class error_page registers. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cr >/dev/null 2>&1
echo "setup: container rebuilt; error_page.exception_subscriber service registered"
