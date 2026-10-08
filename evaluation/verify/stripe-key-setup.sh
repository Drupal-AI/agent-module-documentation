#!/usr/bin/env bash
# MEDIUM introspection SETUP: store a known TEST publishable key in stripe.settings. Exit 0.
set -uo pipefail
cd /var/www/html
drush config:set stripe.settings apikey.test.public 'pk_test_KNOWN_key_42' -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: stripe.settings apikey.test.public=pk_test_KNOWN_key_42"
