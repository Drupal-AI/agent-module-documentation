#!/usr/bin/env bash
# Hard reset: remove any previously produced JSON:API OpenAPI spec artifact so the case
# starts from empty state, and restore jsonapi.settings.read_only to the baseline (TRUE).
set -uo pipefail
cd /var/www/html
rm -f /tmp/openapi_jsonapi_eval_spec.json
drush cset jsonapi.settings read_only 1 -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: removed /tmp/openapi_jsonapi_eval_spec.json; read_only=TRUE"
