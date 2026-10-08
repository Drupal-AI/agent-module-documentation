#!/usr/bin/env bash
# next_extras cleanup: delete next_entity_type_config(s): node.article node.page.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\next\Entity\NextEntityTypeConfig;
  foreach (["node.article","node.page"] as $id) { if ($c = NextEntityTypeConfig::load($id)) { $c->delete(); } }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: removed node.article node.page"
