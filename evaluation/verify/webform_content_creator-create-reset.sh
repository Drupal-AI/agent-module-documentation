#!/usr/bin/env bash
# Execution RESET: remove any webform_content_creator config that creates node/article from the
# 'contact' webform, so verify FAILS until the agent creates one. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("webform_content_creator");
  foreach ($s->loadMultiple() as $e) {
    if (($e->get("webform")??"")==="contact" && ($e->get("target_entity_type")??"")==="node" && ($e->get("target_bundle")??"")==="article") { $e->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: no webform_content_creator mapping contact -> node/article"
