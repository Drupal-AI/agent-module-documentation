#!/usr/bin/env bash
# Introspection CLEANUP: delete the csl_known custom block. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  foreach (\Drupal::entityTypeManager()->getStorage("block_content")->loadByProperties(["info" => "csl_known"]) as $b) { $b->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: block_content csl_known removed"
