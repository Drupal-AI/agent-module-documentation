#!/usr/bin/env bash
# Medium (introspection) CLEANUP for composer_deploy version injection.
# Nothing was mutated (the injected version is inherent live state); just rebuild caches
# to leave the site in a clean, consistent state.
set -uo pipefail
cd /var/www/html
drush cr >/dev/null 2>&1
echo "cleanup: caches rebuilt (baseline unchanged)"
