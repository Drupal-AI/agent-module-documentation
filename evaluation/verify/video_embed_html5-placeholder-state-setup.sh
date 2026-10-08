#!/usr/bin/env bash
# Introspection SETUP: set a known non-default placeholder state (add_placeholder=false) so an
# inspecting agent can read it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("video_embed_html5.config")->set("add_placeholder", FALSE)->save();' >/dev/null 2>&1
echo "setup: video_embed_html5.config add_placeholder=false"
