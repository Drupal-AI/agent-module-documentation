#!/usr/bin/env bash
# Introspection SETUP: add two empty-page callbacks; the one at path 'ep-title-path' is titled
# 'EP Title Page'. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("empty_page.settings");
  $now = \Drupal::time()->getRequestTime();
  $c->set("callback_981", ["cid"=>981,"path"=>"ep-other-path","page_title"=>"EP Other","created"=>$now,"updated"=>$now]);
  $c->set("callback_982", ["cid"=>982,"path"=>"ep-title-path","page_title"=>"EP Title Page","created"=>$now,"updated"=>$now]);
  if ((int)($c->get("new_id") ?? 1) < 983) { $c->set("new_id", 983); }
  $c->save();
' >/dev/null 2>&1
drush php:eval '\Drupal::service("router.builder")->rebuild();' >/dev/null 2>&1
echo "setup: empty_page callbacks ep-other-path + ep-title-path('EP Title Page')"
