#!/usr/bin/env bash
# Introspection CLEANUP: remove the node.article override so it falls back to the default. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '$c=\Drupal::configFactory()->getEditable("conflict.settings");$c->clear("resolution_type.node.article")->save();' >/dev/null 2>&1
echo "cleanup: conflict.settings resolution_type.node.article override removed"
