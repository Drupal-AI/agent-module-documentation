#!/usr/bin/env bash
# Execution RESET: ensure swiper_formatter_ckeditor is uninstalled so verify FAILS until the
# agent enables it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pmu swiper_formatter_ckeditor -y >/dev/null 2>&1 || true
echo "reset: swiper_formatter_ckeditor uninstalled"
