#!/usr/bin/env bash
# Introspection SETUP: define a gift-card type cg_promo with display label 'eGift Voucher'. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '  \Drupal::configFactory()->getEditable("commerce_giftcard.giftcard_type.cg_promo")->setData([
    "langcode"=>"en","status"=>true,"dependencies"=>[],
    "id"=>"cg_promo","label"=>"Promo Card","display_label"=>"eGift Voucher","generate"=>["length"=>8],
  ])->save();' >/dev/null 2>&1
echo "setup: commerce_giftcard.giftcard_type.cg_promo display_label='eGift Voucher'"
