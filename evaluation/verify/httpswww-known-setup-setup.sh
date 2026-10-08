#!/usr/bin/env bash
# Introspection SETUP: write a known httpswww.settings config (HTTPS enforced, www prefix
# added, api subdomain excluded) so an inspecting agent can read it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("httpswww.settings")
    ->set("enabled", TRUE)
    ->set("prefix", "yes")
    ->set("scheme", "https")
    ->set("exclude_subdomains", ["api"])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: httpswww.settings enabled=true prefix=yes scheme=https exclude_subdomains=[api]"
