#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# MEDIUM (introspection) setup for decoupled_router.
# Creates a known, resolvable Article node with a FIXED uuid and the alias
# /dr-eval-landing, so the agent can inspect what decoupled_router resolves that
# path to. Cleanup script removes it. Idempotent: clears any prior copy first.
set -uo pipefail
cd /var/www/html

drush php:eval '
  $uuid = "aaaaaaaa-1111-4222-8333-444444444444";
  // Remove any prior alias + node from an earlier run.
  foreach (\Drupal::entityTypeManager()->getStorage("path_alias")->loadByProperties(["alias" => "/dr-eval-landing"]) as $a) { $a->delete(); }
  foreach (\Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["uuid" => $uuid]) as $n) { $n->delete(); }
  $node = \Drupal\node\Entity\Node::create([
    "type" => "article",
    "title" => "Decoupled Router Eval Landing",
    "status" => 1,
    "uuid" => $uuid,
  ]);
  $node->save();
  \Drupal::entityTypeManager()->getStorage("path_alias")->create([
    "path" => "/node/" . $node->id(),
    "alias" => "/dr-eval-landing",
  ])->save();
  print "setup: article nid=" . $node->id() . " uuid=" . $node->uuid() . " alias=/dr-eval-landing\n";
' 2>/dev/null
drush cr >/dev/null 2>&1
