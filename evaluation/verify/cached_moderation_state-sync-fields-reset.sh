#!/usr/bin/env bash
# Execution RESET: moderate bundle cachedmod_sync (which auto-creates the field), then DELETE the
# field instance to simulate an out-of-sync state, so verify FAILS until the agent re-syncs.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\workflows\Entity\Workflow;
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldConfig;
  if(!NodeType::load("cachedmod_sync")){NodeType::create(["type"=>"cachedmod_sync","name"=>"CachedMod Sync"])->save();}
  if(!Workflow::load("cachedmod_wfs")){ $ts=Workflow::load("editorial")->get("type_settings"); $ts["entity_types"]=[]; Workflow::create(["id"=>"cachedmod_wfs","label"=>"CachedMod WFS","type"=>"content_moderation","type_settings"=>$ts])->save(); }
  $w=Workflow::load("cachedmod_wfs");
  if(!in_array("cachedmod_sync",$w->getTypePlugin()->getBundlesForEntityType("node"),TRUE)){ $w->getTypePlugin()->addEntityTypeAndBundle("node","cachedmod_sync"); $w->save(); }
  if($fc=FieldConfig::loadByName("node","cachedmod_sync","cached_moderation_state")){$fc->delete();}
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: cachedmod_sync moderated but cached_moderation_state field instance deleted (out of sync)"
