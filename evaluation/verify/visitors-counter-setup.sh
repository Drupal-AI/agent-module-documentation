#!/usr/bin/env bash
# Introspection SETUP: configure the visitors content hit-counter to also count the 'user' entity
# type so the agent can read which entity types are counted. Baseline is ['node']. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("visitors.config")->set("counter.entity_types", ["node","user"])->save();' >/dev/null 2>&1
echo "setup: visitors.config counter.entity_types=[node,user]"
