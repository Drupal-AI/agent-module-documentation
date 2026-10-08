#!/usr/bin/env bash
# Introspection SETUP: save a known OneTrust consent script into cookiepro.header.settings so
# an inspecting agent can read back the configured data-domain-script id. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("cookiepro.header.settings")
    ->set("scripts", "<script src=\"https://cdn.cookielaw.org/scripttemplates/otSDKStub.js\" type=\"text/javascript\" charset=\"UTF-8\" data-domain-script=\"cp-eval-7788\"></script>")
    ->save();
' >/dev/null 2>&1
echo "setup: cookiepro.header.settings.scripts configured with data-domain-script cp-eval-7788"
