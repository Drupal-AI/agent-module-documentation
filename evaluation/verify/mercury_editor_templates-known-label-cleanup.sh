#!/usr/bin/env bash
# Introspection CLEANUP: delete the created template. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '  $s = \Drupal::entityTypeManager()->getStorage("me_template");
  foreach ($s->loadByProperties(["label" => "ME Known Template"]) as $e) { $e->delete(); }' >/dev/null 2>&1
echo "cleanup: me_template 'ME Known Template' removed"
