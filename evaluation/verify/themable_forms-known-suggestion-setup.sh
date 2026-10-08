#!/usr/bin/env bash
# themable_forms introspection SETUP: create content type themf_disc so the module's form-id/suggestions
# are observable on its node form. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  if (!NodeType::load("themf_disc")) { NodeType::create(["type" => "themf_disc", "name" => "THEMF Disc"])->save(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: content type themf_disc present"
