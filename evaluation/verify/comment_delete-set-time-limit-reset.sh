#!/usr/bin/env bash
# Execution RESET: remove any comment_delete settings from node.field_blog_comments so verify
# FAILS until the agent sets the 600s time limit. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldConfig;
  $f = FieldConfig::loadByName("node","blog_post","field_blog_comments");
  if ($f) { foreach (["operation","visibility","label","message","mode","anonymize","default","time_limit","timer"] as $k) { $f->unsetThirdPartySetting("comment_delete",$k); } $f->save(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.field_blog_comments comment_delete settings cleared"
