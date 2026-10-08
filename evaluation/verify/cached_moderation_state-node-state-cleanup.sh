#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\workflows\Entity\Workflow;
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldConfig;
  $s=\Drupal::entityTypeManager()->getStorage("node");
  $ids=$s->getQuery()->accessCheck(FALSE)->condition("type","cachedmod_known2")->execute(); if($ids){$s->delete($s->loadMultiple($ids));}
  if($w=Workflow::load("cachedmod_wfk2")){ if(in_array("cachedmod_known2",$w->getTypePlugin()->getBundlesForEntityType("node"),TRUE)){$w->getTypePlugin()->removeEntityTypeAndBundle("node","cachedmod_known2");$w->save();} $w->delete(); }
  if($fc=FieldConfig::loadByName("node","cachedmod_known2","cached_moderation_state")){$fc->delete();}
  if($nt=NodeType::load("cachedmod_known2")){$nt->delete();}
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: cachedmod_known2 / cachedmod_wfk2 / node removed"
