#!/usr/bin/env bash
# Introspection SETUP: create an enabled Optimizely project 'optimizely_known' with a known project
# code and a specific target path, so an agent can read it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("optimizely");
  if (!$s->load("optimizely_known")) {
    $s->create([
      "id" => "optimizely_known", "label" => "Optimizely Known",
      "code" => 555000, "state" => TRUE, "paths" => "/optimizely-eval/*",
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: optimizely project optimizely_known code=555000 paths=/optimizely-eval/*"
