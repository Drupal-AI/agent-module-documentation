#!/usr/bin/env bash
# Introspection SETUP: set a Google API key so the site uses the official client (not fallback).
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("gtext.settings")->set("google_api_key","AIzaSyGTEXT-provider-key-456")->save();' >/dev/null 2>&1
echo "setup: gtext.settings google_api_key set (official client will be used)"
