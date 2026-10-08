#!/usr/bin/env bash
# Live-state verification for the "disable the German ('de') language" task.
# PASS when the configurable_language config entity 'de' carries Disable Language's
# third-party setting third_party_settings.disable_language.disable == TRUE, AND the module's
# own manager service reports 'de' among its disabled languages. Also asserts the site default
# / English is NOT disabled (guards against the agent disabling the wrong / every language).
# Prints PASS/FAIL with detail; exits 0 (pass) / 1 (fail). No arguments.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $etm = \Drupal::entityTypeManager()->getStorage("configurable_language");
  $de = $etm->load("de");
  $flag = $de ? (bool) $de->getThirdPartySetting("disable_language", "disable") : FALSE;
  $mgr = \Drupal::service("disable_language.disable_language_manager");
  $disabledCodes = array_keys($mgr->getDisabledLanguages());
  $mgrde = in_array("de", $disabledCodes, TRUE);
  $default = \Drupal::languageManager()->getDefaultLanguage()->getId();
  $defok = !in_array($default, $disabledCodes, TRUE);
  print (($flag && $mgrde && $defok) ? "PASS" : "FAIL")
    . " flag=" . ($flag ? 1 : 0)
    . " mgr=" . ($mgrde ? 1 : 0)
    . " default_safe=" . ($defok ? 1 : 0)
    . " disabled=[" . implode(",", $disabledCodes) . "]\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
