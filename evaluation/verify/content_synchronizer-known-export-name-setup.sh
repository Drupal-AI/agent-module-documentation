#!/usr/bin/env bash
# Introspection SETUP: create a content_synchronizer Export entity named 'CS Staging Bundle'
# so an inspecting agent can read its name back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\content_synchronizer\Entity\ExportEntity;
  foreach (ExportEntity::loadMultiple() as $e) { if ($e->getName() === "CS Staging Bundle") { $e->delete(); } }
  ExportEntity::create(["name" => "CS Staging Bundle", "user_id" => 1, "status" => 1])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: export_entity 'CS Staging Bundle' created"
