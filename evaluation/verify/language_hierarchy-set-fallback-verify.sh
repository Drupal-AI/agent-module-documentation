#!/usr/bin/env bash
# Execution VERIFY: PASS when configurable_language lhc has fallback_langcode === 'lhp'.
# Prints PASS/FAIL; exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\language\Entity\ConfigurableLanguage;
  $lhc = ConfigurableLanguage::load("lhc");
  $fb = $lhc ? $lhc->getThirdPartySetting("language_hierarchy", "fallback_langcode", "") : "no-lang";
  $ok = ($fb === "lhp");
  print ($ok ? "PASS" : "FAIL") . " lhc_fallback=" . var_export($fb, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
