#!/usr/bin/env bash
# Introspection SETUP: no-op. tome_base is enabled on the baseline site; the agent inspects
# module state (drush pm:list) and the sub-modules' info.yml dependencies. Exit 0.
set -uo pipefail
echo "setup: (no-op) inspect tome_base via 'drush pm:list --status=enabled'"
