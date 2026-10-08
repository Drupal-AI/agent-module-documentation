#!/usr/bin/env bash
# Execution CLEANUP: delete 'GLB Inline Panel'.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\node\Entity\Node; foreach (\Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title"=>"GLB Inline Panel"]) as $n) { $n->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: 'GLB Inline Panel' removed"
