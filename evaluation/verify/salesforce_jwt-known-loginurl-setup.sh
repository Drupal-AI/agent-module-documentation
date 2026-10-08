#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("salesforce_auth");
  if ($a = $s->load("sfj_env")) { $a->delete(); }
  $s->create([
    "id" => "sfj_env", "label" => "sfj_env", "provider" => "jwt",
    "provider_settings" => ["login_url" => "https://login.salesforce.com", "consumer_key" => "TESTKEY", "username" => "svc@example.com", "encrypt_key" => ""],
  ])->save();
' >/dev/null 2>&1
echo "setup: salesforce_auth sfj_env login_url=production"
