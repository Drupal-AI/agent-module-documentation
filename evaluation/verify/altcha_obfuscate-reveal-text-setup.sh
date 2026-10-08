#!/usr/bin/env bash
# medium SETUP (altcha_obfuscate): set the global obfuscate_reveal_text to a known value. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("altcha.settings")->set("obfuscate_reveal_text", "Show me")->save();' >/dev/null 2>&1
echo "setup: altcha.settings obfuscate_reveal_text = 'Show me'"
