#!/usr/bin/env bash
# Introspection SETUP: insert one known sentinel row into the event_log_track table so an agent can
# read back its type/description. Removes any prior sentinel first. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::database()->delete("event_log_track")->condition("ref_char","ELT_MED_SENTINEL")->execute();
  \Drupal::database()->insert("event_log_track")->fields([
    "type" => "taxonomy", "operation" => "term insert", "description" => "SENTINEL_DESC_42",
    "path" => "/elt-med", "ref_numeric" => 4242, "ref_char" => "ELT_MED_SENTINEL",
    "uid" => 1, "ip" => "127.0.0.1", "created" => \Drupal::time()->getRequestTime(),
  ])->execute();
' >/dev/null 2>&1
echo "setup: event_log_track row inserted (type=taxonomy, ref_char=ELT_MED_SENTINEL, desc=SENTINEL_DESC_42)"
