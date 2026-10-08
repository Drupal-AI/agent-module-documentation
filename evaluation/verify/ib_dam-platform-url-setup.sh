#!/usr/bin/env bash
# Introspection SETUP: set the default Platform URL.
set -uo pipefail
cd /var/www/html
drush cset ib_dam.settings login_url 'acme.intelligencebank.com' -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: ib_dam.settings.login_url=acme.intelligencebank.com"
