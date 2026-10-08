#!/usr/bin/env bash
# Introspection SETUP: write a schemaless config object config_normalizer_eval.data to the
# ACTIVE storage with intentionally unsorted associative keys, so an agent that reads it back
# through config_normalizer's NormalizedReadOnlyStorage (compare mode) sees the 'sort'
# normalizer put the keys in order. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("config_normalizer_eval.data")
    ->setData(["zebra" => 1, "apple" => 2, "mango" => 3])->save();
' >/dev/null 2>&1
echo "setup: config_normalizer_eval.data written (keys zebra,apple,mango) to active storage"
