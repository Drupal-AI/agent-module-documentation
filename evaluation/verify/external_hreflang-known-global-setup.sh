#!/usr/bin/env bash
# Introspection SETUP: set a known External Hreflang alternate on the GLOBAL metatag defaults so an
# inspecting agent can read it back. Creates the global metatag_defaults if missing. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\metatag\Entity\MetatagDefaults;
  $s = \Drupal::entityTypeManager()->getStorage("metatag_defaults");
  $d = $s->load("global") ?: MetatagDefaults::create(["id"=>"global","label"=>"Global","tags"=>[]]);
  $tags = $d->get("tags") ?: [];
  $tags["hreflang_external"] = "en-us|https://global.exthreflang-probe.example";
  $d->set("tags", $tags)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: metatag global tags.hreflang_external=en-us|https://global.exthreflang-probe.example"
