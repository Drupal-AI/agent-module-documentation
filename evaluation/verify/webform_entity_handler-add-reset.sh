#!/usr/bin/env bash
# Execution RESET: (re)create webform weh_task with NO handlers, so verify FAILS until the
# agent adds a webform_entity_handler that creates a node:article. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\webform\Entity\Webform;
  if ($w = Webform::load("weh_task")) { $w->delete(); }
  Webform::create(["id" => "weh_task", "title" => "WEH Task"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: webform weh_task created with no handlers"
