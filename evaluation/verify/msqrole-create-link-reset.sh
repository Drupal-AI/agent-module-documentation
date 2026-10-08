#!/usr/bin/env bash
# Execution RESET: delete any persistent masquerade-role link for content_editor from msqrole.urls
# so verify FAILS until the agent generates one. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::keyValue("msqrole.urls")->delete(hash("sha256","content_editor"));' >/dev/null 2>&1
echo "reset: no content_editor masquerade link in msqrole.urls"
