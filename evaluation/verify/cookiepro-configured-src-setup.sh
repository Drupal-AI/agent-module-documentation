#!/usr/bin/env bash
# Introspection SETUP: save a known consent script into cookiepro.header.settings so an agent
# can read back the configured script src URL. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("cookiepro.header.settings")
    ->set("scripts", "<script src=\"https://cdn.example.test/cpeval-src-4521.js\" type=\"text/javascript\" data-domain-script=\"abc\"></script>")
    ->save();
' >/dev/null 2>&1
echo "setup: cookiepro.header.settings.scripts configured with src cpeval-src-4521.js"
