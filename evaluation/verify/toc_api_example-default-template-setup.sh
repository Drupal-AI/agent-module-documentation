#!/usr/bin/env bash
# Introspection SETUP: set the 'default' toc_type template (used by toc_api_example) to a
# distinctive value ('tree') so an agent can read it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("toc_api.toc_type.default")->set("options.template", "tree")->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: toc_api.toc_type.default options.template = 'tree'"
