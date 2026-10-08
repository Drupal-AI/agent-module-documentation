#!/usr/bin/env bash
# Execution RESET: (re)create consumer 'cis_hard' with NO image styles attached, so verify
# FAILS until the agent attaches one. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\consumers\Entity\Consumer;
  foreach (\Drupal::entityTypeManager()->getStorage("consumer")->loadByProperties(["client_id"=>"cis_hard"]) as $e) { $e->delete(); }
  Consumer::create(["label"=>"CIS Hard","client_id"=>"cis_hard","image_styles"=>[]])->save();
' >/dev/null 2>&1
echo "reset: consumer cis_hard with no image styles"
