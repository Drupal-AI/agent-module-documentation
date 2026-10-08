#!/usr/bin/env bash
# Introspection SETUP: create role amswap_reviewer and configure an amswap role-menu pair
# mapping it to the 'tools' menu, so an inspecting agent can read which menu is swapped in.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush role:create amswap_reviewer "Amswap Reviewer" >/dev/null 2>&1 || true
drush php:eval '\Drupal::configFactory()->getEditable("amswap.amswapconfig")->set("role_menu_pairs", [["role"=>"amswap_reviewer","menu"=>"tools"]])->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: amswap pair amswap_reviewer -> menu 'tools'"
