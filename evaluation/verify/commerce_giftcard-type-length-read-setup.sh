#!/usr/bin/env bash
# Introspection SETUP: define a gift-card type cg_holiday with code length 16 (config API). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '  \Drupal::configFactory()->getEditable("commerce_giftcard.giftcard_type.cg_holiday")->setData([
    "langcode"=>"en","status"=>true,"dependencies"=>[],
    "id"=>"cg_holiday","label"=>"Holiday Gift Card","display_label"=>"Gift card","generate"=>["length"=>16],
  ])->save();' >/dev/null 2>&1
echo "setup: commerce_giftcard.giftcard_type.cg_holiday generate.length=16"
