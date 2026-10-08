#!/usr/bin/env bash
# Introspection SETUP: toc_api_example builds its TOC from the 'default' toc_type. Set that
# type's title to a distinctive value so an agent can read it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("toc_api.toc_type.default")->set("options.title", "Eval Page Contents")->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: toc_api.toc_type.default options.title = 'Eval Page Contents'"
