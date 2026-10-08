#!/usr/bin/env bash
# Introspection SETUP: select a known content type to report on. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("paragraphs_report.settings")
    ->set("content_types", ["blog_post" => "blog_post"])->save();
' >/dev/null 2>&1
echo "setup: content_types = {blog_post: blog_post}"
