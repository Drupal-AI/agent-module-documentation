#!/usr/bin/env bash
# Execution RESET: create a document media 'MAD Keep Page' with override OFF, so verify FAILS
# until the agent turns it on. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\media\Entity\Media;
  foreach (\Drupal::entityTypeManager()->getStorage("media")->loadByProperties(["name" => "MAD Keep Page"]) as $e) { $e->delete(); }
  Media::create(["bundle" => "document", "name" => "MAD Keep Page", "field_override_mad_module" => FALSE])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: media 'MAD Keep Page' present with override=false"
