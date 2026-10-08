#!/usr/bin/env bash
# Introspection CLEANUP: restore the shipped default citekey pattern. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("bibcite_entity.reference.settings")
    ->set("citekey", ["pattern" => "bibcite_[bibcite_reference:id]"])->save();
' >/dev/null 2>&1
echo "cleanup: citekey.pattern reset to bibcite_[bibcite_reference:id]"
