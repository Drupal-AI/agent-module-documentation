#!/usr/bin/env bash
# Introspection SETUP: store a known data structure in a config object (dbug.eval_known) so an
# agent can use the dbug module's Dbug::debug() to dump it on the live site and read a value
# back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("dbug.eval_known")
    ->setData(["color" => "green", "count" => 3, "nested" => ["label" => "alpha"]])
    ->save();
' >/dev/null 2>&1
echo "setup: config dbug.eval_known = {color: green, count: 3, nested.label: alpha}"
