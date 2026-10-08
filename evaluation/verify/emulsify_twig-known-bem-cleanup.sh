#!/usr/bin/env bash
# Introspection CLEANUP: remove the known template installed by the matching setup.
# Restores baseline. Idempotent. Exit 0.
set -uo pipefail
rm -f /var/www/html/web/sites/default/files/emulsify_twig_eval/known.html.twig
rmdir /var/www/html/web/sites/default/files/emulsify_twig_eval 2>/dev/null
echo "cleanup: known.html.twig removed"
exit 0
