#!/usr/bin/env bash
# Execution RESET: create a namespaced Key gemini_task_key and clear gemini_provider.settings
# api_key (verify FAILS until the agent selects the key). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\key\Entity\Key;
  if (!Key::load("gemini_task_key")) {
    Key::create([
      "id"=>"gemini_task_key","label"=>"Gemini Task Key",
      "key_type"=>"authentication","key_provider"=>"config",
      "key_provider_settings"=>["key_value"=>"DUMMYTASKKEY"],
    ])->save();
  }
  \Drupal::configFactory()->getEditable("gemini_provider.settings")->set("api_key", "")->save();
' >/dev/null 2>&1
echo "reset: Key gemini_task_key present, api_key empty"
