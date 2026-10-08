#!/usr/bin/env bash
# Introspection CLEANUP: restore shipped dubbot.settings defaults.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("dubbot.settings")
    ->set("embed_key", "")
    ->set("api_url", "https://api.dubbot.com")
    ->set("dialog_renderer", "off_canvas")
    ->set("preview_selector", "#page")
    ->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: dubbot.settings restored to defaults"
