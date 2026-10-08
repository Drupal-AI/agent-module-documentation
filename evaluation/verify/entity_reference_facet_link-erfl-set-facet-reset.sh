#!/usr/bin/env bash
# Execution RESET: field_erfl_pick uses the Facet link formatter but with NO facet selected
# (facet=""), so verify FAILS until the agent points it at facet 'erfl_hard_facet'.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if (!\Drupal\field\Entity\FieldStorageConfig::loadByName("node","field_erfl_pick")) {
    \Drupal\field\Entity\FieldStorageConfig::create(["field_name"=>"field_erfl_pick","entity_type"=>"node","type"=>"entity_reference","settings"=>["target_type"=>"node"]])->save();
  }
  if (!\Drupal\field\Entity\FieldConfig::loadByName("node","article","field_erfl_pick")) {
    \Drupal\field\Entity\FieldConfig::create(["field_name"=>"field_erfl_pick","entity_type"=>"node","bundle"=>"article","label"=>"ERFL Pick"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_erfl_pick",["type"=>"entity_reference_facet_link","settings"=>["facet"=>""],"label"=>"above","weight"=>53,"region"=>"content"])->save();
' >/dev/null 2>&1
echo "reset: field_erfl_pick Facet link formatter with no facet selected"
