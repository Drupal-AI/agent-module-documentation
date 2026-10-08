#!/usr/bin/env bash
# Introspection SETUP: place a mailing_list_subscribe block (id mlist_known) configured to
# subscribe to the list newsletter@lists.example.com, so an inspecting agent can read which list
# the block targets. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $theme = \Drupal::config("system.theme")->get("default");
  if (!\Drupal\block\Entity\Block::load("mlist_known")) {
    \Drupal\block\Entity\Block::create([
      "id"=>"mlist_known","plugin"=>"mailing_list_subscribe","region"=>"content","theme"=>$theme,
      "settings"=>["id"=>"mailing_list_subscribe","label"=>"Subscribe","label_display"=>"0","mailing_list"=>"newsletter@lists.example.com"],
      "visibility"=>[],
    ])->save();
  }
' >/dev/null 2>&1
echo "setup: block mlist_known (mailing_list_subscribe) targets newsletter@lists.example.com"
