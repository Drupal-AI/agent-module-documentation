#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("salesforce_auth");
  if ($a = $s->load("sfj_ltask")) { $a->delete(); }
  $s->create([
    "id" => "sfj_ltask", "label" => "sfj_ltask", "provider" => "jwt",
    "provider_settings" => ["login_url" => "https://test.salesforce.com", "consumer_key" => "TESTKEY", "username" => "svc@example.com", "encrypt_key" => ""],
  ])->save();
' >/dev/null 2>&1
echo "reset: salesforce_auth sfj_ltask login_url=sandbox"
