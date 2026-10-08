#!/usr/bin/env bash
# Introspection SETUP: create a namespaced Key entity gemini_eval_key and point the Gemini
# provider's api_key config at it, so the agent must inspect config to say which key is used.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\key\Entity\Key;
  if (!Key::load("gemini_eval_key")) {
    Key::create([
      "id"=>"gemini_eval_key","label"=>"Gemini Eval Key",
      "key_type"=>"authentication","key_provider"=>"config",
      "key_provider_settings"=>["key_value"=>"DUMMYEVALKEY"],
    ])->save();
  }
  \Drupal::configFactory()->getEditable("gemini_provider.settings")
    ->set("api_key", "gemini_eval_key")->save();
' >/dev/null 2>&1
echo "setup: gemini_provider.settings api_key=gemini_eval_key (Key entity created)"
