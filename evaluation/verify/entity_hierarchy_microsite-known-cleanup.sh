#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  foreach (\Drupal::entityTypeManager()->getStorage("entity_hierarchy_microsite")->loadByProperties(["name" => "EHM Known Site"]) as $ms) { $ms->delete(); }
  foreach (\Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title" => "EHM Home Node"]) as $n) { $n->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: EHM Known Site + EHM Home Node removed"
