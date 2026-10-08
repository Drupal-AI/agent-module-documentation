#!/usr/bin/env bash
# Reset to a clean baseline before the "build an outage alert" execution case: delete every
# sitewide_alert content entity (baseline has none) and restore alert_styles to default so
# each run starts from empty. After this no alerts exist.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("sitewide_alert");
  foreach ($s->loadMultiple() as $a) { $a->delete(); }
  \Drupal::configFactory()->getEditable("sitewide_alert.settings")
    ->set("alert_styles", "primary|Default")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: all sitewide alerts deleted, alert_styles restored to default"
