#!/usr/bin/env bash
# Introspection SETUP (purge_purger_http): create a known httppurgersettings config entity
# pph_known so an inspecting agent can read back its request method / hostname. Idempotent.
# Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\purge_purger_http\Entity\HttpPurgerSettings;
  $s = HttpPurgerSettings::load("pph_known") ?: HttpPurgerSettings::create(["id" => "pph_known"]);
  $s->name = "Known Varnish";
  $s->invalidationtype = "tag";
  $s->hostname = "cache.pphknown.test";
  $s->port = 80;
  $s->path = "/";
  $s->request_method = "PURGE";
  $s->scheme = "http";
  $s->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: purge_purger_http.settings.pph_known (request_method PURGE, hostname cache.pphknown.test)"
