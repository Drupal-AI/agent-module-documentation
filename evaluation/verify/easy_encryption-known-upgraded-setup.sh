#!/usr/bin/env bash
# Introspection SETUP: create a Key ee_intro_upgraded using the insecure 'config' provider; Easy
# Encryption's key_presave hook transparently upgrades it to easy_encrypted. The agent inspects the
# resulting provider.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\key\Entity\Key;
  if ($k = Key::load("ee_intro_upgraded")) { $k->delete(); }
  Key::create(["id"=>"ee_intro_upgraded","label"=>"EE Intro Upgraded","key_type"=>"authentication","key_provider"=>"config","key_provider_settings"=>[],"key_input"=>"text_field"])->setKeyValue("intro-value")->save();
' >/dev/null 2>&1
echo "setup: Key ee_intro_upgraded created via config provider (auto-upgraded)"
