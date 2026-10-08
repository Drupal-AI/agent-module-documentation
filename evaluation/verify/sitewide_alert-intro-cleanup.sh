#!/usr/bin/env bash
# Introspection cleanup: restore baseline after the medium cases by deleting every "Eval "
# sitewide_alert entity and restoring sitewide_alert.settings:alert_styles to its install
# default. Idempotent — a no-op if nothing matches.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("sitewide_alert");
  foreach ($s->loadByProperties([]) as $a) {
    if (str_starts_with((string) $a->label(), "Eval ")) { $a->delete(); }
  }
  \Drupal::configFactory()->getEditable("sitewide_alert.settings")
    ->set("alert_styles", "primary|Default")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: Eval sitewide alerts removed, alert_styles restored to default"
