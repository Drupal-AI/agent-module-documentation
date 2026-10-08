#!/usr/bin/env bash
# Introspection SETUP: set the GLightbox global lightbox width (glightbox.settings custom.width) to a
# distinctive value so an agent can read it back. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("glightbox.settings")->set("custom.width","77%")->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: glightbox.settings custom.width=77%"
