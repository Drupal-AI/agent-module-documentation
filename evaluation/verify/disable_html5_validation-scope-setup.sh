#!/usr/bin/env bash
# Introspection SETUP: create content type dhv_scope for the global-scope check.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  if (!NodeType::load("dhv_scope")) {
    NodeType::create(["type" => "dhv_scope", "name" => "DHV Scope"])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: content type dhv_scope present"
