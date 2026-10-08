#!/usr/bin/env bash
# Introspection SETUP: create a KNOWN configurable language ('de', German) and mark it DISABLED
# via Disable Language's third-party setting, so an inspecting agent can read it back off the
# configurable_language config entity (third_party_settings.disable_language.disable).
# Redirect language is set to the site default (en). English/default is never touched.
# Idempotent (re-creates the flag if 'de' already exists). Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $etm = \Drupal::entityTypeManager()->getStorage("configurable_language");
  if (!$etm->load("de")) { \Drupal\language\Entity\ConfigurableLanguage::createFromLangcode("de")->save(); }
  $l = $etm->load("de");
  $l->setThirdPartySetting("disable_language", "disable", TRUE);
  $l->setThirdPartySetting("disable_language", "redirect_language", "en");
  $l->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: language 'de' (German) exists and is marked disabled (redirect -> en)"
