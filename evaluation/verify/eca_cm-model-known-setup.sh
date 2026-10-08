#!/usr/bin/env bash
# Introspection SETUP: create an ECA model 'eca_cm_known' authored by the core modeller. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("eca");
  if (!$s->load("eca_cm_known")) {
    $s->create(["id" => "eca_cm_known", "label" => "CM Known", "modeller" => "core", "status" => TRUE,
      "events" => [], "conditions" => [], "actions" => [], "gateways" => [], "version" => "1.0.0"])->save();
  }
' >/dev/null 2>&1
echo "setup: eca.eca.eca_cm_known created (modeller=core)"
