#!/usr/bin/env bash
# Introspection SETUP: enable monitoring_mail and seed known settings (mail + severities) to read back.
# Baseline uninstalled; cleanup uninstalls. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pm:install monitoring_mail -y >/dev/null 2>&1
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("monitoring_mail.settings");
  $c->set("mail", "alerts@probe.test");
  $c->set("severities", ["CRITICAL", "WARNING"]);
  $c->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: monitoring_mail enabled; mail=alerts@probe.test severities=[CRITICAL,WARNING]"
