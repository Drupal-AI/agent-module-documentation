#!/usr/bin/env bash
# Introspection SETUP: create the bibcite_export bulk action 'Export reference'
# (bibcite_export_multiple, over bibcite_reference), so an agent can inspect it. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\system\Entity\Action;
  if (!Action::load("bibcite_export_multiple")) {
    Action::create(["id" => "bibcite_export_multiple", "label" => "Export reference", "type" => "bibcite_reference", "plugin" => "bibcite_export_multiple", "configuration" => []])->save();
  }
' >/dev/null 2>&1
echo "setup: action bibcite_export_multiple exists (type bibcite_reference)"
