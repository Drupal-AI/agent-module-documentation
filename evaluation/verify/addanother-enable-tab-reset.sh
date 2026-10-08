#!/usr/bin/env bash
# Execution RESET: force the blog_post 'Add another' tab OFF so verify FAILS until enabled.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("addanother.settings");
  $c->set("default_tab", TRUE)->set("tab.blog_post", FALSE)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: addanother.settings tab.blog_post=false"
