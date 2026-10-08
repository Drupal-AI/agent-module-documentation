#!/usr/bin/env bash
# Introspection SETUP: set the Disqus site shortname (disqus.settings:disqus_domain) to a known
# value so an inspecting agent can read it back. Idempotent.
set -uo pipefail
cd /var/www/html
drush cset disqus.settings disqus_domain dqmodtest -y >/dev/null 2>&1
echo "setup: disqus.settings disqus_domain=dqmodtest"
