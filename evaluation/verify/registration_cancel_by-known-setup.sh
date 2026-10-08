#!/usr/bin/env bash
# Introspection SETUP: create a registration_settings entity (synthetic host node/999601) with a
# known cancel_by deadline so an agent can read it back.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\registration\Entity\RegistrationSettings;
  $existing = \Drupal::entityTypeManager()->getStorage("registration_settings")->loadByProperties(["entity_type_id"=>"node","entity_id"=>999601]);
  $s = $existing ? reset($existing) : RegistrationSettings::create(["entity_type_id"=>"node","entity_id"=>999601,"langcode"=>"en"]);
  $s->set("cancel_by","2030-09-15T17:00:00");
  $s->save();
' >/dev/null 2>&1
echo "setup: registration_settings for node/999601 cancel_by=2030-09-15T17:00:00"
