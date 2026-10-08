#!/usr/bin/env bash
# Introspection SETUP: create a custom token TYPE tc_promo (config entity) beside default 'custom'.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\token_custom\Entity\TokenCustomType;
  if ($t = TokenCustomType::load("tc_promo")) { $t->delete(); }
  TokenCustomType::create(["machineName"=>"tc_promo","name"=>"Promotions","description"=>"Promo tokens"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: custom token type tc_promo created"
