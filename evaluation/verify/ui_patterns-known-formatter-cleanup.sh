#!/usr/bin/env bash
# restore baseline: put the Article body field back on the stock text formatter.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::service("entity_display.repository")->getViewDisplay("node","article","default")
    ->setComponent("body", ["type" => "text_default", "label" => "hidden", "weight" => 1, "region" => "content", "settings" => []])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: node.article body restored to text_default"
