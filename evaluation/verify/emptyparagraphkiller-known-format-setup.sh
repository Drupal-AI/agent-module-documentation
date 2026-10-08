#!/usr/bin/env bash
# Introspection SETUP (epk M1): create a text format 'epk_known' with the Empty Paragraph
# filter enabled. The agent must inspect the live format config to report which filter plugin
# is active. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  if (!FilterFormat::load("epk_known")) {
    FilterFormat::create(["format"=>"epk_known","name"=>"EPK Known","weight"=>20,
      "filters"=>["emptyparagraphkiller"=>["id"=>"emptyparagraphkiller","provider"=>"emptyparagraphkiller","status"=>TRUE,"weight"=>50,"settings"=>[]]]])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: text format epk_known has emptyparagraphkiller filter enabled"
