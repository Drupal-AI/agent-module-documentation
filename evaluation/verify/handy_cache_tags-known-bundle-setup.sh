#!/usr/bin/env bash
# Introspection SETUP: create a namespaced content type hct_probe so an agent must discover it and
# derive its handy_cache_tags bundle cache tag. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  if (!NodeType::load("hct_probe")) {
    NodeType::create(["type" => "hct_probe", "name" => "HCT Probe"])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: content type hct_probe exists (bundle tag handy_cache_tags:node:hct_probe)"
