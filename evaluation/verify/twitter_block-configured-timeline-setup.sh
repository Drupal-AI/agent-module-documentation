#!/usr/bin/env bash
# Introspection SETUP: place a KNOWN twitter_block block instance `eval_twtr_intro`
# so an inspecting agent can read its configured timeline settings back via drush.
# Known facts baked in here:
#   username    = drupalorg
#   theme       = dark
#   tweet_limit = 7
# Idempotent: deletes any prior eval_twtr_intro first. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("block");
  if ($b = $storage->load("eval_twtr_intro")) { $b->delete(); }
  $theme = \Drupal::config("system.theme")->get("default");
  $storage->create([
    "id" => "eval_twtr_intro",
    "plugin" => "twitter_block",
    "region" => "content",
    "theme" => $theme,
    "settings" => [
      "id" => "twitter_block",
      "label" => "Eval Intro Timeline",
      "label_display" => "visible",
      "username" => "drupalorg",
      "theme" => "dark",
      "tweet_limit" => "7",
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: block eval_twtr_intro placed (twitter_block; username drupalorg, theme dark, tweet_limit 7)"
