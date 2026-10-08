#!/usr/bin/env bash
# Medium setup: put JSON:API into a known READ-WRITE state (read_only disabled) so the
# agent can inspect the live jsonapi.settings and reason that the `jsonapi` openapi
# generator WILL document mutating endpoints (POST/PATCH/DELETE) in the spec.
set -uo pipefail
cd /var/www/html
drush cset jsonapi.settings read_only 0 -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: jsonapi.settings.read_only = FALSE"
