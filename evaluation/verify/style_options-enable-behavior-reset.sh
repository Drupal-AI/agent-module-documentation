#!/usr/bin/env bash
# Execution RESET: ensure paragraph type so_task exists with the style_options behavior NOT enabled,
# so verify FAILS until the agent enables it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\paragraphs\Entity\ParagraphsType;
  if ($pt = ParagraphsType::load("so_task")) { $pt->delete(); }
  ParagraphsType::create(["id" => "so_task", "label" => "SO Task"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: paragraph type so_task exists WITHOUT style_options behavior"
