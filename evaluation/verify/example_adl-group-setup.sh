#!/usr/bin/env bash
# Introspection SETUP: ensure example_advanced_datalayer is enabled so its tag plugins are
# discoverable (the fact under test is that ga_client_id belongs to the site_Information group). Exit 0.
set -uo pipefail
cd /var/www/html
if ! drush pm:list --status=enabled --field=name 2>/dev/null | grep -qx example_advanced_datalayer; then
  drush en example_advanced_datalayer -y >/dev/null 2>&1
fi
echo "setup: example_advanced_datalayer enabled; tag plugins available"
