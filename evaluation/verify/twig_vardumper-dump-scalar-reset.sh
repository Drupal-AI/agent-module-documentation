#!/usr/bin/env bash
# Reset for the "dump a scalar with dump()" execution case: remove any previously built
# template so the case starts from empty state (verify must FAIL). No-op beyond that —
# the module needs no state and verify enables Twig debug in-process, so nothing global
# is mutated.
set -uo pipefail
cd /var/www/html
rm -f web/sites/default/files/twig_vardumper-eval/dump.html.twig
drush cr >/dev/null 2>&1
echo "reset: removed web/sites/default/files/twig_vardumper-eval/dump.html.twig"
