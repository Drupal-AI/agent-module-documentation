#!/usr/bin/env bash
# Introspection SETUP: enable specific built-in default patterns (headings + buttons) in the
# styleguide settings so an agent can read back which are on. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("simple_styleguide.styleguidesettings")
    ->set("default_patterns", ["headings"=>"headings","buttons"=>"buttons","text"=>0,"lists"=>0,"blockquote"=>0,"rule"=>0,"table"=>0,"alerts"=>0,"breadcrumbs"=>0,"forms"=>0,"pagination"=>0])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: simple_styleguide.styleguidesettings default_patterns headings+buttons enabled"
