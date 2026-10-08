#!/usr/bin/env bash
# Introspection CLEANUP: undo the matching setup by deleting the eval-added 'de' language,
# restoring the site to its English-only baseline. Only removes the eval language; never
# touches the site default / English. Idempotent. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $l = \Drupal::entityTypeManager()->getStorage("configurable_language")->load("de");
  if ($l && $l->id() !== \Drupal::languageManager()->getDefaultLanguage()->getId()) { $l->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: removed eval language 'de'; site restored to baseline"
