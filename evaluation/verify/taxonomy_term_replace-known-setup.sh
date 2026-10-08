#!/usr/bin/env bash
# Introspection SETUP: create vocabulary ttr_known, a term "Popular Known", a term-reference field
# field_ttr_kref on Article, and TWO published nodes referencing that term. Populates taxonomy_index
# so an agent can report how many published nodes use the term. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  use Drupal\taxonomy\Entity\Term;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\node\Entity\Node;
  if (!Vocabulary::load("ttr_known")) { Vocabulary::create(["vid"=>"ttr_known","name"=>"TTR Known"])->save(); }
  $terms = \Drupal::entityTypeManager()->getStorage("taxonomy_term")->loadByProperties(["name"=>"Popular Known","vid"=>"ttr_known"]);
  $term = $terms ? reset($terms) : NULL;
  if (!$term) { $term = Term::create(["name"=>"Popular Known","vid"=>"ttr_known"]); $term->save(); }
  if (!FieldStorageConfig::loadByName("node","field_ttr_kref")) {
    FieldStorageConfig::create(["field_name"=>"field_ttr_kref","entity_type"=>"node","type"=>"entity_reference","settings"=>["target_type"=>"taxonomy_term"]])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_ttr_kref")) {
    FieldConfig::create(["field_name"=>"field_ttr_kref","entity_type"=>"node","bundle"=>"article","label"=>"TTR Kref","settings"=>["handler"=>"default:taxonomy_term","handler_settings"=>["target_bundles"=>["ttr_known"=>"ttr_known"]]]])->save();
  }
  // remove any prior probe nodes, then create exactly two published ones
  foreach (\Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title"=>"TTR_KNOWN_NODE"]) as $n) { $n->delete(); }
  foreach ([1,2] as $i) {
    Node::create(["type"=>"article","title"=>"TTR_KNOWN_NODE","status"=>1,"field_ttr_kref"=>["target_id"=>$term->id()]])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: vocabulary ttr_known, term 'Popular Known', 2 published nodes reference it via field_ttr_kref"
