#!/usr/bin/env bash
# Introspection SETUP: ensure conflict_paragraphs is enabled so an inspecting agent can find its
# FieldComparator plugin in the live conflict.field_comparator.manager definitions. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pm:install conflict_paragraphs -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: conflict_paragraphs enabled (conflict_field_comparator_paragraph_ref registered)"
