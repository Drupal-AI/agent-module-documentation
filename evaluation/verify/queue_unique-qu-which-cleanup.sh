#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  $db=\Drupal::database();
  $db->delete("queue_unique")->condition("name","qu_alpha")->execute();
  $db->delete("queue_unique")->condition("name","qu_beta")->execute();
' >/dev/null 2>&1
echo "cleanup: qu_alpha + qu_beta emptied"
