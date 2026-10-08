#!/usr/bin/env bash
# Introspection CLEANUP: entity_events is part of the site baseline (always enabled) so there is
# nothing to restore; leave it enabled. Exit 0.
set -uo pipefail
cd /var/www/html
echo "cleanup: entity_events left enabled (site baseline)"
