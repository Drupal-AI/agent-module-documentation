#!/usr/bin/env bash
# Introspection SETUP: create a custom Kint helper config (kint.helper.kdump) so an agent can
# discover the extra dump function. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("kint.helper.kdump")
    ->set("renderer", "Kint\\Renderer\\PlainRenderer")
    ->set("cli_detection", TRUE)
    ->set("mode", "messenger")
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: kint.helper.kdump created (renderer=PlainRenderer, mode=messenger)"
