#!/usr/bin/env bash
# Introspection SETUP: create a bibcite reference type (bundle) 'bibcite_known_type', so an agent
# can inspect the bibcite_reference_type config entities and find it. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\bibcite_entity\Entity\ReferenceType;
  if (!ReferenceType::load("bibcite_known_type")) {
    ReferenceType::create(["id" => "bibcite_known_type", "label" => "Bibcite Known Type"])->save();
  }
' >/dev/null 2>&1
echo "setup: bibcite_reference_type bibcite_known_type created"
