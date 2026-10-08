#!/usr/bin/env bash
# Introspection SETUP: register the node type ogui_grp as an OG group and hand-edit its OgRole
# entities the way the og_ui permission matrix would - the member role gets 'manage members'
# and a custom role node-ogui_grp-editor is added with 'update group'. The agent must read the
# live og.og_role.* config. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\og\Og;
  use Drupal\og\Entity\OgRole;
  if (!NodeType::load("ogui_grp")) { NodeType::create(["type" => "ogui_grp", "name" => "OG UI Probe Group"])->save(); }
  if (!Og::isGroup("node", "ogui_grp")) { Og::groupTypeManager()->addGroup("node", "ogui_grp"); }
  $member = OgRole::load("node-ogui_grp-member");
  $member->grantPermission("manage members");
  $member->save();
  if (!OgRole::load("node-ogui_grp-editor")) {
    OgRole::create([
      "name" => "editor", "label" => "OG UI Editor",
      "group_type" => "node", "group_bundle" => "ogui_grp",
    ])->save();
  }
  $editor = OgRole::load("node-ogui_grp-editor");
  $editor->grantPermission("update group");
  $editor->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node-ogui_grp-member has 'manage members'; custom role node-ogui_grp-editor has 'update group'"
