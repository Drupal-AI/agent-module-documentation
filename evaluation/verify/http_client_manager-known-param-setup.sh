#!/usr/bin/env bash
# Introspection SETUP: create http_config_request hcm_eval_m1 (FindPost, postId=7). Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("http_config_request");
  if ($e = $s->load("hcm_eval_m1")) { $e->delete(); }
  $s->create(["id"=>"hcm_eval_m1","label"=>"HCM Eval M1","service_api"=>"example_services","command_name"=>"FindPost","parameters"=>["postId"=>"7"]])->save();
' >/dev/null 2>&1
echo "setup: http_config_request hcm_eval_m1 FindPost postId=7"
