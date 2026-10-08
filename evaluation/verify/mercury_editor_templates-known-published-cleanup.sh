#!/usr/bin/env bash
# Introspection CLEANUP: delete both created templates. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '  $s = \Drupal::entityTypeManager()->getStorage("me_template");
  foreach ($s->loadByProperties(["label" => "ME Pub Template"]) as $e) { $e->delete(); }  $s = \Drupal::entityTypeManager()->getStorage("me_template");
  foreach ($s->loadByProperties(["label" => "ME Draft Template"]) as $e) { $e->delete(); }' >/dev/null 2>&1
echo "cleanup: 'ME Pub Template' + 'ME Draft Template' removed"
