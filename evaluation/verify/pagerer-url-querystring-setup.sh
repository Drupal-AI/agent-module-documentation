#!/usr/bin/env bash
# Introspection SETUP: configure Pagerer's URL querystring override to one-based paging with a
# custom key 'pgr_q', so the agent can inspect pagerer.settings and report it. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("pagerer.settings");
  $c->set("url_querystring.core_override", TRUE)
    ->set("url_querystring.querystring_key", "pgr_q")
    ->set("url_querystring.index_base", 1)
    ->set("url_querystring.encode_method", "none")
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: pagerer.settings url_querystring -> core_override=TRUE, key=pgr_q, index_base=1"
