#!/usr/bin/env bash
# Execution RESET: create image style ac_task with NO effects, so verify FAILS until the agent adds
# the Automated Crop effect. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\image\Entity\ImageStyle;
  if ($s = ImageStyle::load("ac_task")) { $s->delete(); }
  ImageStyle::create(["name" => "ac_task", "label" => "AC Task"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: image style ac_task exists with no effects"
