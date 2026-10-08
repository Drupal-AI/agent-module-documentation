#!/usr/bin/env bash
# Introspection SETUP: set a known allowed-domains list on noreferrer.settings so an agent can
# read it back from live config. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("noreferrer.settings")
    ->set("allowed_domains", ["example.com", "trusted-partner.org"])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: noreferrer.settings allowed_domains = [example.com, trusted-partner.org]"
