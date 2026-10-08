#!/usr/bin/env bash
# Introspection CLEANUP: no-op. The submodule is intentionally left enabled (it is a
# dependency of the documented WebP behaviour and other cases rely on it). Exit 0.
set -uo pipefail
cd /var/www/html
echo "cleanup: image_styles_generator_webp left enabled (baseline for WebP cases)"
