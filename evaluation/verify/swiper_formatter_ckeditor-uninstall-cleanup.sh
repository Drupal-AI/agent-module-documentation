#!/usr/bin/env bash
# Execution CLEANUP: ensure swiper_formatter_ckeditor is uninstalled (baseline). Idempotent.
set -uo pipefail
cd /var/www/html
drush pmu swiper_formatter_ckeditor -y >/dev/null 2>&1 || true
echo "cleanup: swiper_formatter_ckeditor uninstalled"
