#!/usr/bin/env bash
# Introspection SETUP: no-op. Tome and all its sub-modules are already enabled on the
# baseline site; the agent inspects live module state (drush pm:list) to answer. Exit 0.
set -uo pipefail
echo "setup: (no-op) inspect enabled Tome sub-modules via 'drush pm:list --status=enabled'"
