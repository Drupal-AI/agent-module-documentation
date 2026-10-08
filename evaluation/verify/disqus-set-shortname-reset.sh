#!/usr/bin/env bash
# Execution RESET: clear the Disqus shortname so verify FAILS until the agent sets it. Idempotent.
set -uo pipefail
cd /var/www/html
drush cset disqus.settings disqus_domain '' -y >/dev/null 2>&1
echo "reset: disqus.settings disqus_domain='' (unset)"
