#!/usr/bin/env bash
# Introspection SETUP: create an easy_encrypted Key ee_intro_direct with a known value, so the agent
# must retrieve (decrypt) it through the site.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\key\Entity\Key;
  if ($k = Key::load("ee_intro_direct")) { $k->delete(); }
  Key::create(["id"=>"ee_intro_direct","label"=>"EE Intro Direct","key_type"=>"authentication","key_provider"=>"easy_encrypted","key_provider_settings"=>[],"key_input"=>"text_field"])->setKeyValue("hunter2secret")->save();
' >/dev/null 2>&1
echo "setup: Key ee_intro_direct (easy_encrypted) stores hunter2secret"
