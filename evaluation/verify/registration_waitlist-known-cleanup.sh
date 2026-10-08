#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  foreach (\Drupal::entityTypeManager()->getStorage("registration_settings")->loadByProperties(["entity_type_id"=>"node","entity_id"=>999501]) as $s) { $s->delete(); }
' >/dev/null 2>&1
echo "cleanup: registration_settings for node/999501 removed"
