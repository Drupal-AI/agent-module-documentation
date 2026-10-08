#!/usr/bin/env bash
# Reset for the "per-bundle Article metatag defaults" execution task: delete the node__article
# metatag_defaults config entity so the agent starts from a clean slate. This entity does not
# ship by default, so deleting it is safe (the shipped `global` entity is never touched).
# Idempotent: no-op if already absent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("metatag.metatag_defaults.node__article")->delete();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: metatag node__article defaults removed"
