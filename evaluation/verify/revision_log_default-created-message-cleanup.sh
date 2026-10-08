#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  foreach (\Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title" => "RLD Known Created"]) as $e) { $e->delete(); }
' >/dev/null 2>&1
echo "cleanup: node 'RLD Known Created' deleted"
