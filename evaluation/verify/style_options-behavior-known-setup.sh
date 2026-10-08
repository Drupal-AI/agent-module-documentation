#!/usr/bin/env bash
# Introspection SETUP: create paragraph type so_known and enable the style_options paragraph
# behavior on it, so an agent can read back which paragraph type has Style Options enabled. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\paragraphs\Entity\ParagraphsType;
  $pt = ParagraphsType::load("so_known") ?: ParagraphsType::create(["id" => "so_known", "label" => "SO Known"]);
  $pt->save();
  $pt->getBehaviorPlugin("style_options")->setConfiguration(["enabled" => TRUE]);
  $pt->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: paragraph type so_known has style_options behavior enabled"
