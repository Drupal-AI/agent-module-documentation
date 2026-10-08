#!/usr/bin/env bash
# Introspection SETUP: set a known PDF toolkit in printable.settings.pdf_tool so an agent can
# read back which PDF tool is configured. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset printable.settings pdf_tool tcpdf -y >/dev/null 2>&1
echo "setup: printable.settings pdf_tool = tcpdf"
