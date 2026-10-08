#!/usr/bin/env bash
# Introspection SETUP: create the VBO export action 'Download Selected Citations'
# (bibcite_export_multiple_vbo), so an agent can read its label. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\system\Entity\Action;
  if (!Action::load("bibcite_export_vbo_known")) {
    Action::create(["id" => "bibcite_export_vbo_known", "label" => "Download Selected Citations", "type" => "bibcite_reference", "plugin" => "bibcite_export_multiple_vbo", "configuration" => []])->save();
  }
' >/dev/null 2>&1
echo "setup: VBO export action bibcite_export_vbo_known exists"
