#!/usr/bin/env bash
# Introspection SETUP: add content type bnic_faq. No nodes. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  if (!NodeType::load("bnic_faq")) { NodeType::create(["type" => "bnic_faq", "name" => "BNIC FAQ"])->save(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: content type bnic_faq added"
