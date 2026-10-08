#!/usr/bin/env bash
# Reset for the "dump an array with vardumper()" execution case: remove any previously
# built template so the case starts from empty state (verify must FAIL). Nothing global is
# mutated; verify enables Twig debug in-process.
set -uo pipefail
cd /var/www/html
rm -f web/sites/default/files/twig_vardumper-eval/vardumper.html.twig
drush cr >/dev/null 2>&1
echo "reset: removed web/sites/default/files/twig_vardumper-eval/vardumper.html.twig"
