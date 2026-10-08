#!/usr/bin/env bash
# Execution CLEANUP: uninstall swiper_formatter_ckeditor (restore baseline). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pmu swiper_formatter_ckeditor -y >/dev/null 2>&1 || true
echo "cleanup: swiper_formatter_ckeditor uninstalled"
