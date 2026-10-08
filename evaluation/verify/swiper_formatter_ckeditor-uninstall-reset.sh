#!/usr/bin/env bash
# Execution RESET: ensure swiper_formatter_ckeditor is enabled so verify FAILS until the agent
# uninstalls it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush en swiper_formatter_ckeditor -y >/dev/null 2>&1 || true
echo "reset: swiper_formatter_ckeditor enabled"
