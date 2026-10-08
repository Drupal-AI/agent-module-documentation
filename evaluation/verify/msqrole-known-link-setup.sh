#!/usr/bin/env bash
# Introspection SETUP: generate a persistent masquerade-role link for the content_editor role
# via the msqrole manager, storing it in the msqrole.urls key/value collection. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::service("msqrole.manager")->generateUrl(["content_editor"], FALSE);' >/dev/null 2>&1
echo "setup: msqrole.urls has a persistent link granting role content_editor"
