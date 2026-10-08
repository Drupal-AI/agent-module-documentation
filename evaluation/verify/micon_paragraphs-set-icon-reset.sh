#!/usr/bin/env bash
# Execution RESET: ensure paragraphs type micon_pg_task exists with NO Micon icon. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\paragraphs\Entity\ParagraphsType;
  $t = ParagraphsType::load("micon_pg_task") ?: ParagraphsType::create(["id"=>"micon_pg_task","label"=>"Micon PG Task"]);
  $t->unsetThirdPartySetting("micon_paragraphs","icon");
  $t->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: paragraphs_type micon_pg_task present, no micon icon"
