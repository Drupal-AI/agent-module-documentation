#!/usr/bin/env bash
# Execution CLEANUP: remove the whole namespaced up_* fixture by name. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\field\Entity\FieldStorageConfig; use Drupal\field\Entity\FieldConfig; use Drupal\node\Entity\NodeType; use Drupal\paragraphs\Entity\ParagraphsType;
$nst=\Drupal::entityTypeManager()->getStorage("node"); foreach($nst->loadByProperties(["type"=>"up_page"]) as $n){$n->delete();}
$pst=\Drupal::entityTypeManager()->getStorage("paragraph"); foreach($pst->loadByProperties(["type"=>"up_text"]) as $p){$p->delete();}
if($fc=FieldConfig::loadByName("node","up_page","field_up_paras")){$fc->delete();}
if($fs=FieldStorageConfig::loadByName("node","field_up_paras")){$fs->delete();}
if($fc=FieldConfig::loadByName("paragraph","up_text","field_up_body")){$fc->delete();}
if($fs=FieldStorageConfig::loadByName("paragraph","field_up_body")){$fs->delete();}
if($nt=NodeType::load("up_page")){$nt->delete();}
if($pt=ParagraphsType::load("up_text")){$pt->delete();}' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: up_* fixture removed"
