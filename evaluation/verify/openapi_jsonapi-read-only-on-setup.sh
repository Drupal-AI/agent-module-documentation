#!/usr/bin/env bash
# Medium setup: put JSON:API into a known READ-ONLY state so the agent can inspect the
# live jsonapi.settings and reason about what the `jsonapi` openapi generator would emit
# (read-only => only GET/HEAD/OPTIONS/TRACE documented, mutating endpoints dropped).
set -uo pipefail
cd /var/www/html
drush cset jsonapi.settings read_only 1 -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: jsonapi.settings.read_only = TRUE"
