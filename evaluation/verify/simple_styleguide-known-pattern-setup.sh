#!/usr/bin/env bash
# Introspection SETUP: create a styleguide_pattern config entity so an agent can inspect the
# site and report the custom pattern's machine id. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\simple_styleguide\Entity\StyleguidePattern;
  if (!StyleguidePattern::load("ssg_known")) {
    StyleguidePattern::create(["id"=>"ssg_known","label"=>"SSG Known Card","pattern"=>"<div class=\"ssg-known\">Known</div>","weight"=>0])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: styleguide_pattern ssg_known created"
