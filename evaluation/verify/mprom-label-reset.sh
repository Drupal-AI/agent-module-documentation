#!/usr/bin/env bash
# Execution RESET: ensure monitoring_prometheus enabled and custom_labels EMPTY (verify FAILS until set). Exit 0.
set -uo pipefail
cd /var/www/html
drush pm:install monitoring_prometheus -y >/dev/null 2>&1
drush php:eval '$c=\Drupal::configFactory()->getEditable("monitoring_prometheus.settings"); $c->set("custom_labels", [])->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: monitoring_prometheus enabled; custom_labels empty"
