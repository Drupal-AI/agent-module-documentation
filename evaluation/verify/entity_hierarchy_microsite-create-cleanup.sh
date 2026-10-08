#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  foreach (\Drupal::entityTypeManager()->getStorage("entity_hierarchy_microsite")->loadByProperties(["name" => "EHM Task Site"]) as $ms) { $ms->delete(); }
  foreach (\Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title" => "EHM Task Home"]) as $n) { $n->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: EHM Task Site + EHM Task Home removed"
