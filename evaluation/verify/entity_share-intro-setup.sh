#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# Introspection SETUP: install KNOWN Entity Share config entities so an inspecting agent can
# read them back. Creates a server `channel` (eval_intro_channel: node/article/en) and a client
# `remote` (eval_intro_remote: url https://hub.eval.example.com). Ensures the client+server
# submodules are enabled first. Idempotent: deletes any prior eval_intro_* first. Only touches
# eval_intro_* — leaves any existing entity_share config untouched. Exits 0.
set -uo pipefail
cd /var/www/html
drush en entity_share_server entity_share_client -y >/dev/null 2>&1
drush php:eval '
  $cs = \Drupal::entityTypeManager()->getStorage("channel");
  $rs = \Drupal::entityTypeManager()->getStorage("remote");
  if ($c = $cs->load("eval_intro_channel")) { $c->delete(); }
  if ($r = $rs->load("eval_intro_remote")) { $r->delete(); }
  $cs->create([
    "id" => "eval_intro_channel",
    "label" => "Eval Intro Channel",
    "channel_entity_type" => "node",
    "channel_bundle" => "article",
    "channel_langcode" => "en",
  ])->save();
  $rs->create([
    "id" => "eval_intro_remote",
    "label" => "Eval Intro Remote",
    "url" => "https://hub.eval.example.com",
    "auth" => ["pid" => "anonymous", "uuid" => "", "data" => []],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: eval_intro_channel (node/article/en) + eval_intro_remote (https://hub.eval.example.com) installed"
