#!/usr/bin/env bash
# Introspection CLEANUP: restore Markdownify node bundle config to shipped default
# (default:true, selected:[] = all bundles). Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("markdownify.settings")
    ->set("supported_entities.node.bundles", ["default"=>TRUE,"selected"=>[]])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: markdownify node bundles restored to default (all)"
