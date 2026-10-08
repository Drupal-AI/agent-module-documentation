#!/usr/bin/env bash
# Introspection SETUP: restrict Markdownify for nodes to ONLY the 'page' bundle
# (default:false, selected:[page]) so an agent can read back which node bundle is enabled.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("markdownify.settings")
    ->set("supported_entities.node.bundles", ["default"=>FALSE,"selected"=>["page"]])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: markdownify node bundles = only 'page'"
