#!/usr/bin/env bash
# Introspection SETUP: create a PATH-type custom_breadcrumbs entity cb_known matching /cb-known/*,
# so an agent can read back its path pattern. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\custom_breadcrumbs\Entity\CustomBreadcrumbs;
  if (!CustomBreadcrumbs::load("cb_known")) {
    CustomBreadcrumbs::create([
      "id" => "cb_known", "label" => "CB Known", "status" => TRUE, "description" => "",
      "type" => 2, "entityType" => "", "entityBundle" => "", "language" => "und",
      "pathPattern" => "/cb-known/*",
      "breadcrumbPaths" => "/cb-known", "breadcrumbTitles" => "CB Known Section",
      "extraCacheContexts" => "",
    ])->save();
  }
' >/dev/null 2>&1
echo "setup: custom_breadcrumbs cb_known (path type) pathPattern=/cb-known/*"
