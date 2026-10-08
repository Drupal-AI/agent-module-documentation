#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::database()->delete("queue_unique")->condition("name","qu_known")->execute();' >/dev/null 2>&1
echo "cleanup: qu_known emptied"
