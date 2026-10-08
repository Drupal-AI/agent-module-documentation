#!/usr/bin/env bash
# Introspection SETUP: configure a 3600s delete time limit on node.field_blog_comments. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldConfig;
  $f = FieldConfig::loadByName("node","blog_post","field_blog_comments");
  if ($f) {
    $f->setThirdPartySetting("comment_delete","operation",["soft"=>"soft"]);
    $f->setThirdPartySetting("comment_delete","time_limit",TRUE);
    $f->setThirdPartySetting("comment_delete","timer",3600);
    $f->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.field_blog_comments comment_delete.time_limit=true timer=3600"
