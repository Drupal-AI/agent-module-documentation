#!/usr/bin/env bash
# Execution RESET: registration_settings for synthetic host node/999602 exists with cancel_by EMPTY.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\registration\Entity\RegistrationSettings;
  $existing = \Drupal::entityTypeManager()->getStorage("registration_settings")->loadByProperties(["entity_type_id"=>"node","entity_id"=>999602]);
  $s = $existing ? reset($existing) : RegistrationSettings::create(["entity_type_id"=>"node","entity_id"=>999602,"langcode"=>"en"]);
  $s->set("cancel_by",NULL);
  $s->save();
' >/dev/null 2>&1
echo "reset: registration_settings for node/999602 cancel_by=EMPTY"
