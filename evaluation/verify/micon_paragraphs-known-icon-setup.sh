#!/usr/bin/env bash
# Introspection SETUP: create paragraphs type micon_pg_med with a Micon icon (fa-cube).
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\paragraphs\Entity\ParagraphsType;
  $t = ParagraphsType::load("micon_pg_med") ?: ParagraphsType::create(["id"=>"micon_pg_med","label"=>"Micon PG Med"]);
  $t->setThirdPartySetting("micon_paragraphs","icon","fa-cube");
  $t->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: paragraphs_type micon_pg_med icon=fa-cube"
