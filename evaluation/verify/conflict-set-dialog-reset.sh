#!/usr/bin/env bash
# Execution RESET: ensure Article uses inline resolution (remove any node.article override AND set
# resolution_type.node.article=inline) so verify FAILS until the agent switches it to dialog. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("conflict.settings")->set("resolution_type.node.article","inline")->save();' >/dev/null 2>&1
echo "reset: conflict.settings resolution_type.node.article=inline"
