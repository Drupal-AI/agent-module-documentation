#!/usr/bin/env bash
# Introspection SETUP: create consumer 'cis_eval' with image styles thumbnail + large attached.
# Idempotent (recreates cleanly). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\consumers\Entity\Consumer;
  $existing = \Drupal::entityTypeManager()->getStorage("consumer")->loadByProperties(["client_id"=>"cis_eval"]);
  foreach ($existing as $e) { $e->delete(); }
  Consumer::create(["label"=>"CIS Eval","client_id"=>"cis_eval","image_styles"=>["thumbnail","large"]])->save();
' >/dev/null 2>&1
echo "setup: consumer cis_eval with image_styles [thumbnail, large]"
