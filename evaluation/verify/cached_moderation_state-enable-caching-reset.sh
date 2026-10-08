#!/usr/bin/env bash
# Execution RESET: create content type cachedmod_page and a content_moderation workflow
# cachedmod_wfp, but ensure cachedmod_page is NOT moderated and has NO cached_moderation_state
# field, so verify FAILS until the agent enables moderation-state caching for the bundle.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\workflows\Entity\Workflow;
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldConfig;
  if (!NodeType::load("cachedmod_page")) { NodeType::create(["type" => "cachedmod_page", "name" => "CachedMod Page"])->save(); }
  if (!Workflow::load("cachedmod_wfp")) {
    $ts = Workflow::load("editorial")->get("type_settings");
    $ts["entity_types"] = [];
    Workflow::create(["id" => "cachedmod_wfp", "label" => "CachedMod WFP", "type" => "content_moderation", "type_settings" => $ts])->save();
  }
  $w = Workflow::load("cachedmod_wfp");
  if (in_array("cachedmod_page", $w->getTypePlugin()->getBundlesForEntityType("node"), TRUE)) {
    $w->getTypePlugin()->removeEntityTypeAndBundle("node", "cachedmod_page"); $w->save();
  }
  if ($fc = FieldConfig::loadByName("node", "cachedmod_page", "cached_moderation_state")) { $fc->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: cachedmod_page exists, NOT moderated, no cached_moderation_state field (workflow cachedmod_wfp available)"
