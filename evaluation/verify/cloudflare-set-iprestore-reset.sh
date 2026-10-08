#!/usr/bin/env bash
# Execution RESET: restore shipped defaults (client_ip_restore_enabled=false, bypass_host='').
set -uo pipefail
cd /var/www/html
drush php:eval '$c=\Drupal::configFactory()->getEditable("cloudflare.settings");$c->set("client_ip_restore_enabled",FALSE)->set("remote_addr_validate",TRUE)->set("bypass_host","")->set("valid_credentials",FALSE)->set("zones",[])->set("auth_using","token")->set("api_token","")->set("apikey","")->set("email","")->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: cloudflare.settings at shipped defaults"
