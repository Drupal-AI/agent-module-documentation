#!/usr/bin/env bash
# CLEANUP: restore the 'node' context to its shipped empty tags map. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '$d = \Drupal::entityTypeManager()->getStorage("advanced_datalayer_defaults")->load("node"); $d->set("tags", [])->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: advanced_datalayer_defaults.node tags reset to {}"
