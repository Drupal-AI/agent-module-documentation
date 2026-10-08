#!/usr/bin/env bash
# Introspection SETUP (entity_reference_override formatter-def): the module adds Field API plugins but
# no config of its own; the agent inspects the live plugin definitions. No mutation. Idempotent.
set -uo pipefail
cd /var/www/html
echo "setup: inspect entity_reference_override's field plugin definitions in the live site"
