#!/usr/bin/env bash
# Introspection SETUP (entity_reference_override_entity_browser M1): thin widget shim, no config
# of its own; the agent inspects the live field-widget plugin definition. No mutation. Idempotent.
set -uo pipefail
cd /var/www/html
echo "setup: inspect entity_reference_override_entity_browser's field widget plugin in the live site"
