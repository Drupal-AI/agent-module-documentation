#!/usr/bin/env bash
# Execution RESET: ensure token type tc_dept and any token 'tc_manager' are absent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\token_custom\Entity\TokenCustom;
  use Drupal\token_custom\Entity\TokenCustomType;
  if ($e = TokenCustom::load("tc_manager")) { $e->delete(); }
  if ($t = TokenCustomType::load("tc_dept")) { $t->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: token type tc_dept and token tc_manager removed (absent)"
