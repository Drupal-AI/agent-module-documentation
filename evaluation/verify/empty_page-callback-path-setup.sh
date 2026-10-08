#!/usr/bin/env bash
# Introspection SETUP: add an empty-page callback at internal path 'ep-eval-path' titled
# 'EP Eval'. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("empty_page.settings");
  $now = \Drupal::time()->getRequestTime();
  $c->set("callback_991", ["cid"=>991,"path"=>"ep-eval-path","page_title"=>"EP Eval","created"=>$now,"updated"=>$now]);
  if ((int)($c->get("new_id") ?? 1) < 992) { $c->set("new_id", 992); }
  $c->save();
' >/dev/null 2>&1
drush php:eval '\Drupal::service("router.builder")->rebuild();' >/dev/null 2>&1
echo "setup: empty_page callback_991 path=ep-eval-path title='EP Eval'"
