#!/usr/bin/env bash
# Execution CLEANUP: restore disqus.settings:disqus_domain to shipped default ''.
set -uo pipefail
cd /var/www/html
drush cset disqus.settings disqus_domain '' -y >/dev/null 2>&1
echo "cleanup: disqus.settings disqus_domain restored to ''"
