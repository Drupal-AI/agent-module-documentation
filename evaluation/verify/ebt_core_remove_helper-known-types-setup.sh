#!/usr/bin/env bash
# Introspection SETUP: create an EBT-prefixed block content type (ebt_rhprobe) so the agent can
# find it by the ebt_ prefix on the live site. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("block_content_type");
  if (!$s->load("ebt_rhprobe")) {
    $s->create(["id"=>"ebt_rhprobe","label"=>"EBT RH Probe"])->save();
  }
' >/dev/null 2>&1
echo "setup: block_content_type ebt_rhprobe created"
