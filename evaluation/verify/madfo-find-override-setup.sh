#!/usr/bin/env bash
# Introspection SETUP: create two document media items — 'MAD Eval Override' with the override
# field ON and 'MAD Eval Normal' with it OFF — so an agent can find which one overrides. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\media\Entity\Media;
  foreach (["MAD Eval Override" => TRUE, "MAD Eval Normal" => FALSE] as $name => $flag) {
    $existing = \Drupal::entityTypeManager()->getStorage("media")->loadByProperties(["name" => $name]);
    foreach ($existing as $e) { $e->delete(); }
    Media::create(["bundle" => "document", "name" => $name, "field_override_mad_module" => $flag])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: media 'MAD Eval Override' (override=true), 'MAD Eval Normal' (override=false)"
