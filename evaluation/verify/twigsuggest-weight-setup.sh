#!/usr/bin/env bash
# Introspection SETUP: no state to write -- the module's install weight (100) is a live fact in
# core.extension the agent must read. Idempotent no-op.
set -uo pipefail
cd /var/www/html
echo "setup: (none) twigsuggest install weight is discoverable in core.extension"
