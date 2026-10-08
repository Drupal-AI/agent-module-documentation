#!/usr/bin/env bash
# Execution RESET: delete the wrapper template the agent must write; ensure the directory
# exists and is writable. Idempotent. Exit 0.
set -uo pipefail
mkdir -p /var/www/html/web/sites/default/files/emulsify_twig_eval
chmod 777 /var/www/html/web/sites/default/files/emulsify_twig_eval 2>/dev/null
rm -f /var/www/html/web/sites/default/files/emulsify_twig_eval/wrapper.html.twig
echo "reset: wrapper.html.twig removed"
exit 0
