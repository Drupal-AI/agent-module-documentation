#!/usr/bin/env bash
# Introspection SETUP: create a custom CSL style config entity 'bibcite_known_style', so an agent
# can inspect the bibcite_csl_style entities and report the custom style. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\bibcite\Entity\CslStyle;
  if (!CslStyle::load("bibcite_known_style")) {
    CslStyle::create(["id" => "bibcite_known_style", "label" => "Bibcite Known Style", "csl" => "<style/>", "custom" => TRUE])->save();
  }
' >/dev/null 2>&1
echo "setup: bibcite_csl_style bibcite_known_style created"
