#!/usr/bin/env bash
# Introspection SETUP: install a KNOWN forum structure in the `forums` vocabulary so an
# inspecting agent can read it back: a container "Eval Zone" (forum_container=1) with a
# leaf forum "Eval Lounge" (forum_container=0) nested inside it.
# Idempotent: removes any prior Eval Zone / Eval Lounge terms first. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("taxonomy_term");
  foreach (["Eval Zone", "Eval Lounge"] as $name) {
    foreach ($storage->loadByProperties(["vid" => "forums", "name" => $name]) as $t) { $t->delete(); }
  }
  $c = $storage->create(["vid" => "forums", "name" => "Eval Zone", "forum_container" => 1, "weight" => 0]);
  $c->save();
  $f = $storage->create(["vid" => "forums", "name" => "Eval Lounge", "forum_container" => 0, "parent" => $c->id(), "weight" => 0]);
  $f->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: forum container 'Eval Zone' + leaf forum 'Eval Lounge' installed in forums vocab"
