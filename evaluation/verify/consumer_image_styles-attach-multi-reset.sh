#!/usr/bin/env bash
# Execution RESET: (re)create consumer 'cis_hard2' with NO image styles. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\consumers\Entity\Consumer;
  foreach (\Drupal::entityTypeManager()->getStorage("consumer")->loadByProperties(["client_id"=>"cis_hard2"]) as $e) { $e->delete(); }
  Consumer::create(["label"=>"CIS Hard2","client_id"=>"cis_hard2","image_styles"=>[]])->save();
' >/dev/null 2>&1
echo "reset: consumer cis_hard2 with no image styles"
