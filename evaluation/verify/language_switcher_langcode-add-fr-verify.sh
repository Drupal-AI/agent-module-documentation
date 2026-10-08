#!/usr/bin/env bash
# Execution VERIFY: PASS when language 'fr' is configured (switcher will show 'FR') and the module is enabled.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\language\Entity\ConfigurableLanguage;
  $lang = (bool) ConfigurableLanguage::load("fr");
  $mod = \Drupal::moduleHandler()->moduleExists("language_switcher_langcode");
  $ok = $lang && $mod;
  print ($ok ? "PASS" : "FAIL") . " lang_fr=" . var_export($lang, TRUE) . " module=" . var_export($mod, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
