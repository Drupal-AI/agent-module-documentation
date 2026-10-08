#!/usr/bin/env bash
# Introspection SETUP: create role amswap_reviewer and configure an amswap role-menu pair
# (amswap_reviewer -> 'main') whose ignored_roles contains 'administrator', so an inspecting
# agent can read which roles suppress the swap. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush role:create amswap_reviewer "Amswap Reviewer" >/dev/null 2>&1 || true
drush php:eval '\Drupal::configFactory()->getEditable("amswap.amswapconfig")->set("role_menu_pairs", [["role"=>"amswap_reviewer","menu"=>"main","ignored_roles"=>["administrator"]]])->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: amswap pair amswap_reviewer -> menu 'main', ignored_roles=[administrator]"
