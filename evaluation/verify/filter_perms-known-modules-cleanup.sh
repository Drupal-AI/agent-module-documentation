#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::keyValueExpirable("filter_perms_list")->delete("1");' >/dev/null 2>&1
echo "cleanup: filter_perms_list[1] deleted"
