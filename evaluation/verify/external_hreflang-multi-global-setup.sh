#!/usr/bin/env bash
# Introspection SETUP: set TWO External Hreflang alternates (two lines) on the global metatag
# defaults so an inspecting agent must parse them and list the external URLs. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\metatag\Entity\MetatagDefaults;
  $s = \Drupal::entityTypeManager()->getStorage("metatag_defaults");
  $d = $s->load("global") ?: MetatagDefaults::create(["id"=>"global","label"=>"Global","tags"=>[]]);
  $tags = $d->get("tags") ?: [];
  $tags["hreflang_external"] = "en-us|https://us.exthreflang-probe.example\nes-es|https://es.exthreflang-probe.example";
  $d->set("tags", $tags)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: global tags.hreflang_external=us+es exthreflang-probe alternates"
