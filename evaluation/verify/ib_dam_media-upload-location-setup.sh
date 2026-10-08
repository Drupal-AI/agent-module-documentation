#!/usr/bin/env bash
# Introspection SETUP: set ib_dam_media upload location.
set -uo pipefail
cd /var/www/html
drush cset ib_dam_media.settings upload_location 'public://ib_dam_assets_probe' -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: ib_dam_media.settings.upload_location=public://ib_dam_assets_probe"
