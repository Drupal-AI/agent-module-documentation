#!/usr/bin/env bash
# Execution RESET: create vocabulary ttr_task with terms 'ttr_old' and 'ttr_new', a term-reference
# field field_ttr_tref on Article, and one published node TTR_TASK_NODE referencing 'ttr_old'.
# Verify FAILS until the agent replaces the reference with 'ttr_new'. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  use Drupal\taxonomy\Entity\Term;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\node\Entity\Node;
  if (!Vocabulary::load("ttr_task")) { Vocabulary::create(["vid"=>"ttr_task","name"=>"TTR Task"])->save(); }
  $ts=\Drupal::entityTypeManager()->getStorage("taxonomy_term");
  $get=function($name) use ($ts){ $r=$ts->loadByProperties(["name"=>$name,"vid"=>"ttr_task"]); if($r) return reset($r); $t=Term::create(["name"=>$name,"vid"=>"ttr_task"]); $t->save(); return $t; };
  $old=$get("ttr_old"); $new=$get("ttr_new");
  if (!FieldStorageConfig::loadByName("node","field_ttr_tref")) {
    FieldStorageConfig::create(["field_name"=>"field_ttr_tref","entity_type"=>"node","type"=>"entity_reference","settings"=>["target_type"=>"taxonomy_term"]])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_ttr_tref")) {
    FieldConfig::create(["field_name"=>"field_ttr_tref","entity_type"=>"node","bundle"=>"article","label"=>"TTR Tref","settings"=>["handler"=>"default:taxonomy_term","handler_settings"=>["target_bundles"=>["ttr_task"=>"ttr_task"]]]])->save();
  }
  foreach (\Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title"=>"TTR_TASK_NODE"]) as $n) { $n->delete(); }
  Node::create(["type"=>"article","title"=>"TTR_TASK_NODE","status"=>1,"field_ttr_tref"=>["target_id"=>$old->id()]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node TTR_TASK_NODE references term ttr_old in vocabulary ttr_task (field_ttr_tref)"
