#!/usr/bin/env bash
# Introspection SETUP: ensure glightbox_inline is enabled so an agent can confirm its status. Idempotent.
set -uo pipefail
cd /var/www/html
if ! drush pm:list --status=enabled --field=name 2>/dev/null | grep -qx glightbox_inline; then
  drush en glightbox_inline -y >/dev/null 2>&1
fi
echo "setup: glightbox_inline is enabled"
