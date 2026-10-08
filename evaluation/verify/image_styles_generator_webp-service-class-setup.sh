#!/usr/bin/env bash
# Introspection SETUP: ensure the image_styles_generator_webp submodule is enabled so the
# image_styles_generator.derivative_warmer service resolves to the WebP subclass, which an
# agent can read back from the live container. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pm:install image_styles_generator_webp -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: image_styles_generator_webp enabled; derivative_warmer service now DerivativeWebpWarmer"
