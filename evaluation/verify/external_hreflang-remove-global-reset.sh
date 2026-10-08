#!/usr/bin/env bash
# Execution RESET: seed an External Hreflang alternate (a de-de toggle marker) on the global
# metatag defaults so the "remove it" task starts from a configured state; verify (which checks
# the marker is ABSENT) then FAILS until the agent removes it. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\metatag\Entity\MetatagDefaults;
  $s = \Drupal::entityTypeManager()->getStorage("metatag_defaults");
  $d = $s->load("global") ?: MetatagDefaults::create(["id"=>"global","label"=>"Global","tags"=>[]]);
  $tags = $d->get("tags") ?: [];
  $tags["hreflang_external"] = "de-de|https://de.exthreflang-toggle.example";
  $d->set("tags", $tags)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: global tags.hreflang_external=de-de toggle marker seeded"
