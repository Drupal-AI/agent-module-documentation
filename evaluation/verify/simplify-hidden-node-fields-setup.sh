#!/usr/bin/env bash
# Introspection SETUP: put a KNOWN global Simplify config on the site so an inspecting agent
# can read it back. Hide three node-form elements globally: Authoring information (author),
# Promotion options (options) and Revision information (revision_information). Written to the
# simplify.global config object (key simplify_nodes_global). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("simplify.global")
    ->set("simplify_nodes_global", ["author", "options", "revision_information"])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: simplify_nodes_global = [author, options, revision_information]"
