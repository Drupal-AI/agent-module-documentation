#!/usr/bin/env bash
# Introspection SETUP: set a known account id and switch loading to synchronous, so an agent can
# read the loading method back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '$c=\Drupal::configFactory()->getEditable("vwo.settings"); $c->set("id", 222333)->set("loading.type", "sync")->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: vwo.settings loading.type = sync (id 222333)"
