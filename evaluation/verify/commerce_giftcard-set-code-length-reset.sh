#!/usr/bin/env bash
# Execution RESET: (re)create gift-card type cg_len with code length 8 so verify FAILS until it is
# changed to 20. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '  \Drupal::configFactory()->getEditable("commerce_giftcard.giftcard_type.cg_len")->setData([
    "langcode"=>"en","status"=>true,"dependencies"=>[],
    "id"=>"cg_len","label"=>"Length Card","display_label"=>"Gift card","generate"=>["length"=>8],
  ])->save();' >/dev/null 2>&1
echo "reset: commerce_giftcard.giftcard_type.cg_len generate.length=8"
