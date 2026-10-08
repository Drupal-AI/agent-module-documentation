#!/usr/bin/env bash
# Introspection CLEANUP: no-op. micon_ckeditor stays enabled (baseline for this assignment) and
# the fa package is a shipped default. Nothing to restore. Exit 0.
set -uo pipefail
cd /var/www/html
echo "cleanup: no-op (micon_ckeditor remains enabled; fa is the shipped package)"
