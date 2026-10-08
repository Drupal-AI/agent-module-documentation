#!/usr/bin/env bash
# Introspection CLEANUP: delete the throwaway block.
set -uo pipefail
cd /var/www/html
drush php:eval 'if($b=\Drupal\block\Entity\Block::load("ccr_cookie_switcher")){$b->delete();}' >/dev/null 2>&1
echo "cleanup: block ccr_cookie_switcher deleted"
