#!/usr/bin/env bash
# Introspection SETUP: point plupload chunk storage at a shared public URI (simulating an HA
# shared temp location) so an agent can identify which stream scheme is in use. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset plupload.settings temporary_uri 'public://plupload_pl_shared' -y >/dev/null 2>&1
echo "setup: plupload.settings temporary_uri = public://plupload_pl_shared"
