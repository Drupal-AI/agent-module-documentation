#!/usr/bin/env bash
# Introspection SETUP: moderate bundle cachedmod_known2 and create a node left in 'draft'. Agent
# reports that node's cached_moderation_state value.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\workflows\Entity\Workflow;
  use Drupal\node\Entity\NodeType;
  use Drupal\node\Entity\Node;
  if(!NodeType::load("cachedmod_known2")){NodeType::create(["type"=>"cachedmod_known2","name"=>"CachedMod Known2"])->save();}
  if(!Workflow::load("cachedmod_wfk2")){ $ts=Workflow::load("editorial")->get("type_settings"); $ts["entity_types"]=[]; Workflow::create(["id"=>"cachedmod_wfk2","label"=>"CachedMod WFK2","type"=>"content_moderation","type_settings"=>$ts])->save(); }
  $w=Workflow::load("cachedmod_wfk2");
  if(!in_array("cachedmod_known2",$w->getTypePlugin()->getBundlesForEntityType("node"),TRUE)){ $w->getTypePlugin()->addEntityTypeAndBundle("node","cachedmod_known2"); $w->save(); }
  $ids=\Drupal::entityTypeManager()->getStorage("node")->getQuery()->accessCheck(FALSE)->condition("type","cachedmod_known2")->execute();
  if(!$ids){ $n=Node::create(["type"=>"cachedmod_known2","title"=>"cms known node","moderation_state"=>"draft"]); $n->save(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: cachedmod_known2 moderated; one node in draft with cached_moderation_state populated"
