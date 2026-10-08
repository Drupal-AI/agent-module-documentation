#!/usr/bin/env bash
# Execution CLEANUP (modal_page H2): restore modal_page.settings to shipped defaults. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("modal_page.settings");
  $c->set("verify_load_bootstrap_automatically", TRUE)
    ->set("load_bootstrap", FALSE)
    ->set("bootstrap_version", "3x")
    ->set("allowed_tags", "h1,h2,a,b,big,code,del,em,i,ins,pre,q,small,span,strong,sub,sup,tt,ol,ul,li,p,br,img")
    ->set("clear_caches_on_modal_save", FALSE)
    ->set("default_cookie_expiration", 10000)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: modal_page.settings restored to shipped defaults"
