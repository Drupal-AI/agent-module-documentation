#!/usr/bin/env bash
# Introspection SETUP: create group type gi_known and install the group_invitation relation on it,
# with a customized plugin config (invitation_expire=14, autoaccept_invitees=true). One atomic drush
# call so the group type and its relation are created together. Lets an agent read back the
# group_content config. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\group\Entity\GroupType;
  if (!GroupType::load("gi_known")) { GroupType::create(["id"=>"gi_known","label"=>"GI Known"])->save(); }
  $grts = \Drupal::entityTypeManager()->getStorage("group_relationship_type");
  $ex = $grts->loadByProperties(["group_type"=>"gi_known","content_plugin"=>"group_invitation"]);
  $rt = $ex ? reset($ex) : $grts->createFromPlugin(GroupType::load("gi_known"), "group_invitation");
  $pc = $rt->get("plugin_config") ?: [];
  $pc["invitation_expire"] = 14; $pc["autoaccept_invitees"] = true;
  $rt->set("plugin_config", $pc)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: group type gi_known has group_invitation installed (invitation_expire=14, autoaccept_invitees=true)"
