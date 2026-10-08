#!/usr/bin/env bash
# Introspection SETUP: create a KNOWN block_group_content config entity so an inspecting
# agent can determine the derived block plugin id (block_group:<id>) it produces on the
# live site. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("block_group_content");
  if ($e = $s->load("eval_promo_sidebar")) { $e->delete(); }
  $s->create(["id" => "eval_promo_sidebar", "label" => "Eval Promo Sidebar"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: block_group_content eval_promo_sidebar created (derives block_group:eval_promo_sidebar)"
