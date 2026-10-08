#!/usr/bin/env bash
# Introspection setup: install KNOWN sitewide_alert entities on the live site so the agent
# can be asked about the current alerts and must inspect the running site (drush) to answer.
# Idempotent — removes any prior "Eval " alerts and re-adds two known ones. Known facts the
# medium cases probe:
#   - "Eval Maintenance Notice": ACTIVE, dismissible, style=danger,
#       message "Scheduled maintenance on Sunday at 03:00 UTC."
#   - "Eval Welcome": INACTIVE, style=info, message "Welcome to our new website."
# Also widens sitewide_alert.settings:alert_styles so danger/info are valid styles.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("sitewide_alert.settings")
    ->set("alert_styles", "primary|Default\ninfo|Information\ndanger|Danger")->save();
  $s = \Drupal::entityTypeManager()->getStorage("sitewide_alert");
  foreach ($s->loadByProperties([]) as $a) {
    if (str_starts_with((string) $a->label(), "Eval ")) { $a->delete(); }
  }
  $a = $s->create([
    "name" => "Eval Maintenance Notice",
    "message" => "Scheduled maintenance on Sunday at 03:00 UTC.",
    "style" => "danger", "status" => TRUE, "dismissible" => TRUE,
  ]);
  $s->save($a);
  $b = $s->create([
    "name" => "Eval Welcome",
    "message" => "Welcome to our new website.",
    "style" => "info", "status" => FALSE, "dismissible" => FALSE,
  ]);
  $s->save($b);
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: 2 known sitewide alerts installed (Eval Maintenance Notice active/danger, Eval Welcome inactive/info)"
