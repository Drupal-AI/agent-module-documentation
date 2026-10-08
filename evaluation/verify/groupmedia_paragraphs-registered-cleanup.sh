#!/usr/bin/env bash
# Introspection CLEANUP: leave groupmedia_paragraphs enabled (its enabled state is the
# documented baseline for the parent's Paragraph tracking). Idempotent no-op. Exit 0.
set -uo pipefail
cd /var/www/html
drush en groupmedia_paragraphs -y >/dev/null 2>&1
echo "cleanup: groupmedia_paragraphs left enabled (baseline)"
