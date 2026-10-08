#!/usr/bin/env bash
# Execution RESET: force embed_provider back to the shipped Iframely default so verify
# FAILS until the agent switches it to Noembed. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset ckeditor_media_embed.settings embed_provider 'http://ckeditor.iframe.ly/api/oembed?url={url}&callback={callback}' -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: embed_provider = Iframely default"
