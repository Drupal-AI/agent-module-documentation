#!/usr/bin/env bash
# Introspection SETUP: create an entityqueue (simple handler) targeting Article nodes so the
# Entityqueue Form Widget would offer it on Article node forms; an agent can inspect the
# entityqueue config to name it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\entityqueue\Entity\EntityQueue;
  if (!EntityQueue::load("eqfw_intro")) {
    EntityQueue::create([
      "id" => "eqfw_intro", "label" => "EQFW Intro Featured", "handler" => "simple",
      "entity_settings" => ["target_type" => "node", "handler" => "default", "handler_settings" => ["target_bundles" => ["article" => "article"]]],
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: entity_queue eqfw_intro targets node:article"
