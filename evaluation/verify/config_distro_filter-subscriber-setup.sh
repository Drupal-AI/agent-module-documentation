#!/usr/bin/env bash
# Introspection SETUP: ensure caches clear so the live event_dispatcher listener list for
# config_distro.transform is accurate; the agent must find that config_distro_filter's subscriber
# is registered for that event. Exit 0.
set -uo pipefail
cd /var/www/html
drush cr >/dev/null 2>&1
echo "setup: inspect event_dispatcher listeners for config_distro.transform"
