#!/usr/bin/env bash
# Execution CLEANUP: restore Markdownify node bundles to shipped default (all). Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("markdownify.settings")
    ->set("supported_entities.node.bundles", ["default"=>TRUE,"selected"=>[]])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: markdownify node bundles restored to default (all)"
