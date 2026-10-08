#!/usr/bin/env bash
# Introspection SETUP: create content type pc_note and set its private_content privacy mode to
# 3 (PRIVATE_ALWAYS / Hidden) so an inspecting agent can read it back. Config only (no node
# access rebuild). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  $t = NodeType::load("pc_note") ?: NodeType::create(["type"=>"pc_note","name"=>"PC Note"]);
  if ($t->isNew()) { $t->save(); $t = NodeType::load("pc_note"); }
  $t->setThirdPartySetting("private_content","private",3);
  $t->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: content type pc_note has private_content.private=3 (Hidden/always private)"
