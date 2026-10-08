#!/usr/bin/env bash
# Introspection CLEANUP: no-op. The submodule is left enabled (baseline for this campaign is
# enabled); disabling it would remove decorators other checks rely on. Exit 0.
set -uo pipefail
echo "cleanup: domain_path_pathauto left enabled (no baseline change)"
