#!/usr/bin/env bash
# Execution RESET: clear the 'node' context tags so verify FAILS until the agent sets event. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '$d = \Drupal::entityTypeManager()->getStorage("advanced_datalayer_defaults")->load("node"); $d->set("tags", [])->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: advanced_datalayer_defaults.node tags = {}"
