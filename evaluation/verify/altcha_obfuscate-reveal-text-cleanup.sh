#!/usr/bin/env bash
# medium CLEANUP (altcha_obfuscate): restore obfuscate_reveal_text to its shipped default (''). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("altcha.settings")->set("obfuscate_reveal_text", "")->save();' >/dev/null 2>&1
echo "cleanup: altcha.settings obfuscate_reveal_text reset to '' (default)"
