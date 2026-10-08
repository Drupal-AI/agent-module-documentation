#!/usr/bin/env bash
# Execution RESET: force the Article display_updated default OFF (FALSE) so a new Article does
# NOT show the updated date; verify FAILS until the agent makes Article default to ON. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $defs = \Drupal::service("entity_field.manager")->getFieldDefinitions("node","article");
  $defs["display_updated"]->getConfig("article")->setDefaultValue(FALSE)->save();
  \Drupal::service("entity_field.manager")->clearCachedFieldDefinitions();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article display_updated default = FALSE"
