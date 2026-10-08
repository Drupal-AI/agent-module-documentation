#!/usr/bin/env bash
# Introspection SETUP: anonymizer has no config of its own; ensure the module is enabled and
# its plugin definitions are fresh so the agent can enumerate the live anonymizer plugins.
# Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::service("plugin.manager.anonymizer")->clearCachedDefinitions();' >/dev/null 2>&1
echo "setup: anonymizer plugin definitions refreshed (enumerate via plugin.manager.anonymizer)"
