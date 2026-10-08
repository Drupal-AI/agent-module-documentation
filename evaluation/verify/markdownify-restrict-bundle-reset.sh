#!/usr/bin/env bash
# Execution RESET: set Markdownify node bundles to shipped default (all bundles enabled:
# default:true, selected:[]) so verify FAILS until the agent restricts to only 'article'.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("markdownify.settings")
    ->set("supported_entities.node.bundles", ["default"=>TRUE,"selected"=>[]])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: markdownify node bundles = all (default)"
