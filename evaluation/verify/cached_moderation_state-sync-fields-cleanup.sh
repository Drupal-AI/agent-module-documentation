#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\workflows\Entity\Workflow;
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldConfig;
  if($w=Workflow::load("cachedmod_wfs")){ if(in_array("cachedmod_sync",$w->getTypePlugin()->getBundlesForEntityType("node"),TRUE)){$w->getTypePlugin()->removeEntityTypeAndBundle("node","cachedmod_sync");$w->save();} $w->delete(); }
  if($fc=FieldConfig::loadByName("node","cachedmod_sync","cached_moderation_state")){$fc->delete();}
  if($nt=NodeType::load("cachedmod_sync")){$nt->delete();}
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: cachedmod_sync / cachedmod_wfs removed"
