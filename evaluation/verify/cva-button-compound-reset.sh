#!/usr/bin/env bash
# Reset for the "button component with a compound variant" execution case: remove any
# previously built template so the case starts from empty state (verify must FAIL).
set -uo pipefail
cd /var/www/html
rm -f web/sites/default/files/cva-eval/button.html.twig
drush cr >/dev/null 2>&1
echo "reset: removed web/sites/default/files/cva-eval/button.html.twig"
