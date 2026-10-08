#!/usr/bin/env bash
# Introspection SETUP: place the cookie switcher block (id ccr_cookie_switcher) in sidebar_first
# of the default theme so the agent can read it back. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $theme=\Drupal::config("system.theme")->get("default");
  if(!\Drupal\block\Entity\Block::load("ccr_cookie_switcher")){
    \Drupal\block\Entity\Block::create([
      "id"=>"ccr_cookie_switcher","plugin"=>"commerce_currency_resolver_cookie",
      "region"=>"sidebar_first","theme"=>$theme,
      "settings"=>["id"=>"commerce_currency_resolver_cookie","label"=>"Currency","label_display"=>"0","provider"=>"commerce_currency_resolver_cookie"],
      "visibility"=>[],"weight"=>0,
    ])->save();
  }
' >/dev/null 2>&1
echo "setup: block ccr_cookie_switcher placed in sidebar_first"
