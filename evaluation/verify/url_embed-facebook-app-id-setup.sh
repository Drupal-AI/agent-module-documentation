#!/usr/bin/env bash
# Introspection SETUP: write a known Facebook App ID to url_embed.settings so the agent must
# inspect the live config to answer. url_embed.settings is not shipped by default (no
# config/install/url_embed.settings.yml), so this also creates the config object. Idempotent.
# Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("url_embed.settings")
    ->set("facebook_app_id", "url_embed_known_fb_app_5551234")
    ->set("facebook_app_secret", "url_embed_known_fb_secret_placeholder")
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: url_embed.settings facebook_app_id=url_embed_known_fb_app_5551234"
