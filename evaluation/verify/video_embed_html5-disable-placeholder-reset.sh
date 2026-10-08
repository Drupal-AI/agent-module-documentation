#!/usr/bin/env bash
# Execution RESET: force add_placeholder back to the shipped default (true) so verify (which
# expects false) FAILS until the agent turns it off. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("video_embed_html5.config")->set("add_placeholder", TRUE)->save();' >/dev/null 2>&1
echo "reset: video_embed_html5.config add_placeholder=true"
