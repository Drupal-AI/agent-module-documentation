#!/usr/bin/env bash
# Execution CLEANUP: remove comment_delete settings from node.comment_forum. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldConfig;
  $f = FieldConfig::loadByName("node","forum","comment_forum");
  if ($f) { foreach (["operation","visibility","label","message","mode","anonymize","default","time_limit","timer"] as $k) { $f->unsetThirdPartySetting("comment_delete",$k); } $f->save(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: node.comment_forum comment_delete settings removed"
