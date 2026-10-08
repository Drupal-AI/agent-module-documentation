#!/usr/bin/env bash
# Introspection SETUP: install a known Twig template on the live site that calls the module's
# bem() function, so the agent has to render/inspect it (not guess) to report the classes the
# running site produces. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush en emulsify_twig -y >/dev/null 2>&1
mkdir -p /var/www/html/web/sites/default/files/emulsify_twig_eval
cat > /var/www/html/web/sites/default/files/emulsify_twig_eval/known.html.twig <<'TWIG'
<h2 {{ bem('headline', ['wide', 'dark'], 'banner', ['js-banner']) }}>Known</h2>
TWIG
echo "setup: wrote web/sites/default/files/emulsify_twig_eval/known.html.twig"
exit 0
