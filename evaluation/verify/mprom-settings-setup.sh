#!/usr/bin/env bash
# Introspection SETUP: enable monitoring_prometheus and seed known settings (allowed_ips=[10.1.2.3],
# custom_labels.env=staging) to read back. Baseline is uninstalled; cleanup uninstalls. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pm:install monitoring_prometheus -y >/dev/null 2>&1
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("monitoring_prometheus.settings");
  $c->set("allowed_ips", ["10.1.2.3"]);
  $c->set("custom_labels", ["env" => "staging"]);
  $c->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: monitoring_prometheus enabled; allowed_ips=[10.1.2.3], custom_labels.env=staging"
