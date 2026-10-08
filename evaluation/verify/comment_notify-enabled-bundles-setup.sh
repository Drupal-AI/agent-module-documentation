#!/usr/bin/env bash
# Introspection SETUP: add node--page--comment to comment_notify bundle_types (alongside the
# shipped node--article--comment). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("comment_notify.settings");
  $bt = $c->get("bundle_types") ?: ["node--article--comment"];
  if (!in_array("node--page--comment", $bt, TRUE)) { $bt[] = "node--page--comment"; }
  $c->set("bundle_types", array_values($bt))->save();
' >/dev/null 2>&1
echo "setup: bundle_types now includes node--page--comment"
