#!/usr/bin/env bash
# Introspection SETUP (uuid_extra): expose the node UUID as a read-only field on the
# Article default FORM display only (not on Page). Known fact to read back: exactly the
# 'article' content type has the uuid widget on its edit form. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $efd = \Drupal::entityTypeManager()->getStorage("entity_form_display");
  $fd = $efd->load("node.article.default");
  $fd->setComponent("uuid", ["type" => "uuid", "weight" => 99, "region" => "content"])->save();
  // Ensure page (if present) does NOT have it.
  if ($pg = $efd->load("node.page.default")) { $pg->removeComponent("uuid")->save(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article default form display exposes uuid (uuid widget); page does not"
