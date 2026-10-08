#!/usr/bin/env bash
# Introspection CLEANUP: uninstall swiper_formatter_ckeditor to restore baseline (it ships
# disabled). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pmu swiper_formatter_ckeditor -y >/dev/null 2>&1 || true
echo "cleanup: swiper_formatter_ckeditor uninstalled"
