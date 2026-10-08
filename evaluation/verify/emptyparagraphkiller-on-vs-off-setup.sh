#!/usr/bin/env bash
# Introspection SETUP (epk M2): create two text formats — 'epk_on' with the Empty Paragraph
# filter ENABLED and 'epk_off' WITHOUT it — so the agent must inspect the live config to tell
# which one strips empty paragraphs. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  if (!FilterFormat::load("epk_on")) {
    FilterFormat::create(["format"=>"epk_on","name"=>"EPK On","weight"=>21,
      "filters"=>["emptyparagraphkiller"=>["id"=>"emptyparagraphkiller","provider"=>"emptyparagraphkiller","status"=>TRUE,"weight"=>50,"settings"=>[]]]])->save();
  }
  if (!FilterFormat::load("epk_off")) {
    FilterFormat::create(["format"=>"epk_off","name"=>"EPK Off","weight"=>22,"filters"=>[]])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: epk_on has emptyparagraphkiller enabled, epk_off does not"
