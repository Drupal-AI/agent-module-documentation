#!/usr/bin/env bash
# HARD (execution) verify: the agent must configure the amazee.ai VectorDB Postgres
# connection in ai_provider_amazeeio.settings — host pg.acme.example, port 5432,
# database acme_vectors, username acme_app. Config-only check (no live DB connection).
# Prints PASS/FAIL and exits 0 (pass) / 1 (fail).
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $c = \Drupal::config("ai_provider_amazeeio.settings");
  $h = $c->get("postgres_host") === "pg.acme.example";
  $p = ((int) $c->get("postgres_port")) === 5432;
  $d = $c->get("postgres_default_database") === "acme_vectors";
  $u = $c->get("postgres_username") === "acme_app";
  print (($h && $p && $d && $u) ? "PASS" : "FAIL")
    . " host=" . ($h?1:0) . " port=" . ($p?1:0) . " db=" . ($d?1:0) . " user=" . ($u?1:0)
    . " (" . $c->get("postgres_host") . ":" . $c->get("postgres_port")
    . "/" . $c->get("postgres_default_database") . " as " . $c->get("postgres_username") . ")\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
