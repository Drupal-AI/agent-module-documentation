#!/usr/bin/env bash
# Introspection SETUP: ensure twig_tools is enabled so an inspecting agent can find its filters in
# the live Twig environment. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pm:install twig_tools -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: twig_tools enabled (Twig filters registered)"
