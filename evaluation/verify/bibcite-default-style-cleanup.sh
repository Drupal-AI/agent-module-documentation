#!/usr/bin/env bash
# Introspection CLEANUP: restore bibcite.settings to the module's shipped defaults.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("bibcite.settings")
    ->set("processor", "citeproc-php")->set("default_style", "apa")->set("convert_urls", FALSE)->save();
' >/dev/null 2>&1
echo "cleanup: bibcite.settings reset to defaults (processor=citeproc-php, default_style=apa)"
