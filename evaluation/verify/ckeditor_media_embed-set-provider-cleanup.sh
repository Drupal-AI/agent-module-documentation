#!/usr/bin/env bash
# Execution CLEANUP: restore the shipped Iframely default provider. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset ckeditor_media_embed.settings embed_provider 'http://ckeditor.iframe.ly/api/oembed?url={url}&callback={callback}' -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: embed_provider restored to the Iframely default"
