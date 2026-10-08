#!/usr/bin/env bash
# Execution RESET: enable sharethis on BOTH article and page (shipped default) so the verify
# (which requires page OFF) FAILS until the agent restricts it to article only. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("sharethis.settings")->set("node_types",["article"=>"article","page"=>"page"])->save();' >/dev/null 2>&1
echo "reset: sharethis.settings node_types = {article, page}"
