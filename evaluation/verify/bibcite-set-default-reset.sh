#!/usr/bin/env bash
# Execution RESET: set bibcite.settings to a NON-target state (default_style=modern_language_association,
# convert_urls=false) so verify (wants default_style=apa AND convert_urls=true) FAILS. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("bibcite.settings")
    ->set("processor", "citeproc-php")->set("default_style", "modern_language_association")->set("convert_urls", FALSE)->save();
' >/dev/null 2>&1
echo "reset: bibcite.settings default_style=modern_language_association, convert_urls=false"
