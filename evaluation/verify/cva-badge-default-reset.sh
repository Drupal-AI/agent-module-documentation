#!/usr/bin/env bash
# Reset for the "badge component with a default variant" execution case: remove any prior
# build so the case starts empty (verify must FAIL until the agent creates the template).
set -uo pipefail
cd /var/www/html
rm -f web/sites/default/files/cva-eval/badge.html.twig
drush cr >/dev/null 2>&1
echo "reset: removed web/sites/default/files/cva-eval/badge.html.twig"
