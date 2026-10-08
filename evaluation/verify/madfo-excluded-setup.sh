#!/usr/bin/env bash
# Introspection SETUP: create a document media 'MAD Eval Excluded' with the override field ON, so
# an agent can confirm it is excluded from Media Alias Display file-serving. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\media\Entity\Media;
  foreach (\Drupal::entityTypeManager()->getStorage("media")->loadByProperties(["name" => "MAD Eval Excluded"]) as $e) { $e->delete(); }
  Media::create(["bundle" => "document", "name" => "MAD Eval Excluded", "field_override_mad_module" => TRUE])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: media 'MAD Eval Excluded' override=true"
