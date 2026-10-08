#!/usr/bin/env bash
# Execution CLEANUP: delete the content_editor masquerade link from msqrole.urls. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::keyValue("msqrole.urls")->delete(hash("sha256","content_editor"));' >/dev/null 2>&1
echo "cleanup: content_editor masquerade link removed from msqrole.urls"
