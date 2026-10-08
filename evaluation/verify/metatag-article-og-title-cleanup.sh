#!/usr/bin/env bash
# Introspection CLEANUP: remove the added per-bundle metatag_defaults `node__article` config
# entity, restoring baseline (it does not ship by default). Idempotent: no-op if already gone.
# Never touches the shipped `global` entity. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("metatag.metatag_defaults.node__article")->delete();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: metatag node__article defaults removed"
