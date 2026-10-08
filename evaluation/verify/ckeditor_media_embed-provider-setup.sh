#!/usr/bin/env bash
# Introspection SETUP: set a known, distinctive oEmbed provider URL in
# ckeditor_media_embed.settings so an inspecting agent can read it back. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset ckeditor_media_embed.settings embed_provider '//noembed.com/embed?url={url}&callback={callback}&ckme_probe=CKMEPROBE1' -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: embed_provider set to the Noembed probe URL (marker ckme_probe=CKMEPROBE1)"
