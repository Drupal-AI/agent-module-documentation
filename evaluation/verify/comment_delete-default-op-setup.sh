#!/usr/bin/env bash
# Introspection SETUP: configure comment_delete on node.comment_forum with default op hard_partial.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldConfig;
  $f = FieldConfig::loadByName("node","forum","comment_forum");
  if ($f) {
    $f->setThirdPartySetting("comment_delete","operation",["hard"=>"hard","hard_partial"=>"hard_partial","soft"=>"soft"]);
    $f->setThirdPartySetting("comment_delete","visibility","visible");
    $f->setThirdPartySetting("comment_delete","default","hard_partial");
    $f->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.comment_forum comment_delete.default=hard_partial"
