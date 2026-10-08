#!/usr/bin/env bash
# Introspection SETUP: place a mailing_list_subscribe block (id mlist_lbl) with the admin/display
# label "Join Our Newsletter" so an inspecting agent can read the block's configured title. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $theme = \Drupal::config("system.theme")->get("default");
  if (!\Drupal\block\Entity\Block::load("mlist_lbl")) {
    \Drupal\block\Entity\Block::create([
      "id"=>"mlist_lbl","plugin"=>"mailing_list_subscribe","region"=>"content","theme"=>$theme,
      "settings"=>["id"=>"mailing_list_subscribe","label"=>"Join Our Newsletter","label_display"=>"visible","mailing_list"=>"list@lists.example.com"],
      "visibility"=>[],
    ])->save();
  }
' >/dev/null 2>&1
echo "setup: block mlist_lbl labelled 'Join Our Newsletter'"
