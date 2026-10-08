#!/usr/bin/env bash
# Introspection SETUP: create content type dhv_known so an inspecting agent can render its
# node form and read the novalidate attribute added by disable_html5_validation. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  if (!NodeType::load("dhv_known")) {
    NodeType::create(["type" => "dhv_known", "name" => "DHV Known"])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: content type dhv_known present"
