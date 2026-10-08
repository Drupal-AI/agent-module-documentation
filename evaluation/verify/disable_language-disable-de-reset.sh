#!/usr/bin/env bash
# Execution RESET for the "disable the German language" task. Guarantees a known starting
# point: German ('de') and French ('fr') both EXIST as configurable languages but are NOT
# disabled (their disable_language third-party flag is cleared). This way verify FAILs on the
# reset state and only PASSes once the agent disables 'de'. Never touches the site default /
# English. Idempotent. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $etm = \Drupal::entityTypeManager()->getStorage("configurable_language");
  foreach (["de", "fr"] as $code) {
    if (!$etm->load($code)) { \Drupal\language\Entity\ConfigurableLanguage::createFromLangcode($code)->save(); }
    $l = $etm->load($code);
    $l->unsetThirdPartySetting("disable_language", "disable");
    $l->unsetThirdPartySetting("disable_language", "redirect_language");
    $l->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: languages 'de' and 'fr' present and enabled (no disable flag) — build target not met"
