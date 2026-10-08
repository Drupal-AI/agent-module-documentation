#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($u = user_load_by_name("bamboo_render_user_71")) { $u->delete(); }
  \Drupal::state()->delete("bamboo_loader_render_uid");
' >/dev/null 2>&1
rm -f web/sites/default/files/bamboo_twig_loader_render_account.html.twig
echo "cleanup: user bamboo_render_user_71 + state + template removed"
