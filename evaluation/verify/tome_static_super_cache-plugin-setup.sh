#!/usr/bin/env bash
# Introspection SETUP: no-op. tome_static_super_cache is enabled on the baseline site; the
# agent inspects the live Views cache plugin registry. Exit 0.
set -uo pipefail
echo "setup: (no-op) inspect Views cache plugins (plugin.manager.views.cache)"
