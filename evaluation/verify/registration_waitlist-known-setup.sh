#!/usr/bin/env bash
# Introspection SETUP: create a registration_settings entity (synthetic host node/999501) with a
# known wait-list capacity so an agent can read it back.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\registration\Entity\RegistrationSettings;
  $existing = \Drupal::entityTypeManager()->getStorage("registration_settings")->loadByProperties(["entity_type_id"=>"node","entity_id"=>999501]);
  $s = $existing ? reset($existing) : RegistrationSettings::create(["entity_type_id"=>"node","entity_id"=>999501,"langcode"=>"en"]);
  $s->set("registration_waitlist_capacity", 15);
  $s->save();
' >/dev/null 2>&1
echo "setup: registration_settings for node/999501 registration_waitlist_capacity=15"
