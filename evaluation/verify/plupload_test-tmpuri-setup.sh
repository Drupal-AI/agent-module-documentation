#!/usr/bin/env bash
# Introspection SETUP: set a known plupload temporary_uri (the demo form at /plupload-test
# stages chunks there) so an agent can read it back. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset plupload.settings temporary_uri 'private://plupload_test_pt' -y >/dev/null 2>&1
echo "setup: plupload.settings temporary_uri = private://plupload_test_pt"
