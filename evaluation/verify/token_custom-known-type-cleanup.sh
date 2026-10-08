#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\token_custom\Entity\TokenCustomType; if ($t = TokenCustomType::load("tc_promo")) { $t->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: token type tc_promo removed"
