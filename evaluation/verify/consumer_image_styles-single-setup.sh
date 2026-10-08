#!/usr/bin/env bash
# Introspection SETUP: create consumer 'cis_medium' with only the 'medium' image style.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\consumers\Entity\Consumer;
  foreach (\Drupal::entityTypeManager()->getStorage("consumer")->loadByProperties(["client_id"=>"cis_medium"]) as $e) { $e->delete(); }
  Consumer::create(["label"=>"CIS Medium","client_id"=>"cis_medium","image_styles"=>["medium"]])->save();
' >/dev/null 2>&1
echo "setup: consumer cis_medium with image_styles [medium]"
