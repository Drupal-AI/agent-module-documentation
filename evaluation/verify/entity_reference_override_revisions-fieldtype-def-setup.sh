#!/usr/bin/env bash
# Introspection SETUP (entity_reference_override_revisions M1): thin field-plugin shim, no config
# of its own; the agent inspects the live field-type plugin definition. No mutation. Idempotent.
set -uo pipefail
cd /var/www/html
echo "setup: inspect entity_reference_override_revisions's field type plugin in the live site"
