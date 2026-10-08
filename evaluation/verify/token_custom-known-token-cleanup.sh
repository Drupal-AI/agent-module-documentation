#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\token_custom\Entity\TokenCustom; if ($e = TokenCustom::load("tc_greeting")) { $e->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: token tc_greeting removed"
