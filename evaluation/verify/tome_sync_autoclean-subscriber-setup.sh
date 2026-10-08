#!/usr/bin/env bash
# Introspection SETUP: no-op. tome_sync_autoclean is enabled on the baseline site; the agent
# inspects module state / the module's event subscriber. Exit 0.
set -uo pipefail
echo "setup: (no-op) inspect tome_sync_autoclean via drush pm:list and its event subscriber"
