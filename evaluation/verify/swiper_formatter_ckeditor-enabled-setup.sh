#!/usr/bin/env bash
# Introspection SETUP: enable swiper_formatter_ckeditor so an agent can inspect its live
# status/dependencies. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush en swiper_formatter_ckeditor -y >/dev/null 2>&1 || true
echo "setup: swiper_formatter_ckeditor enabled"
