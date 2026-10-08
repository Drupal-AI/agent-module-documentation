#!/usr/bin/env bash
# Execution RESET: clear the styleguide settings default_patterns (all disabled) so verify FAILS
# until the agent enables blockquote + table. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("simple_styleguide.styleguidesettings")
    ->set("default_patterns", ["headings"=>0,"text"=>0,"lists"=>0,"blockquote"=>0,"rule"=>0,"table"=>0,"alerts"=>0,"breadcrumbs"=>0,"forms"=>0,"buttons"=>0,"pagination"=>0])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: default_patterns all disabled"
