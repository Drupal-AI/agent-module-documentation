#!/usr/bin/env bash
# Introspection SETUP: create http_config_request hcm_eval_m2 (CreatePost). Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("http_config_request");
  if ($e = $s->load("hcm_eval_m2")) { $e->delete(); }
  $s->create(["id"=>"hcm_eval_m2","label"=>"HCM Eval M2","service_api"=>"example_services","command_name"=>"CreatePost","parameters"=>["title"=>"x","body"=>"y","userId"=>"1"]])->save();
' >/dev/null 2>&1
echo "setup: http_config_request hcm_eval_m2 CreatePost on example_services"
