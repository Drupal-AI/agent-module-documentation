#!/usr/bin/env bash
# Introspection SETUP: enable client IP restore and set a bypass host.
set -uo pipefail
cd /var/www/html
drush php:eval '$c=\Drupal::configFactory()->getEditable("cloudflare.settings");$c->set("client_ip_restore_enabled",TRUE)->set("bypass_host","backend.internal.example")->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: client_ip_restore_enabled=true, bypass_host=backend.internal.example"
