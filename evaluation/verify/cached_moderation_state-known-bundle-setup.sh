#!/usr/bin/env bash
# Introspection SETUP: create content type cachedmod_known and a dedicated content_moderation
# workflow that moderates it, so cached_moderation_state auto-installs its field on that bundle.
# The agent must inspect the site to find which bundle has the cached_moderation_state field.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\workflows\Entity\Workflow;
  use Drupal\node\Entity\NodeType;
  if (!NodeType::load("cachedmod_known")) { NodeType::create(["type" => "cachedmod_known", "name" => "CachedMod Known"])->save(); }
  if (!Workflow::load("cachedmod_wfk")) {
    $ts = Workflow::load("editorial")->get("type_settings");
    $ts["entity_types"] = [];
    Workflow::create(["id" => "cachedmod_wfk", "label" => "CachedMod WFK", "type" => "content_moderation", "type_settings" => $ts])->save();
  }
  $w = Workflow::load("cachedmod_wfk");
  if (!in_array("cachedmod_known", $w->getTypePlugin()->getBundlesForEntityType("node"), TRUE)) {
    $w->getTypePlugin()->addEntityTypeAndBundle("node", "cachedmod_known");
    $w->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.cachedmod_known moderated (workflow cachedmod_wfk); cached_moderation_state field auto-installed"
