#!/usr/bin/env bash
# Introspection SETUP: create the trc_topics vocabulary, two terms, a taxonomy term
# reference field field_trc_topic on Article, and two Articles referencing the "Alpha" term.
# An inspecting agent can then use term_reference_change's reference finder (or plain drush)
# to report which field / how many nodes reference Alpha. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  use Drupal\taxonomy\Entity\Term;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\node\Entity\Node;
  if (!Vocabulary::load("trc_topics")) {
    Vocabulary::create(["vid" => "trc_topics", "name" => "TRC Topics"])->save();
  }
  $terms = [];
  foreach (["Alpha", "Beta"] as $name) {
    $existing = \Drupal::entityTypeManager()->getStorage("taxonomy_term")
      ->loadByProperties(["vid" => "trc_topics", "name" => $name]);
    if ($existing) { $terms[$name] = reset($existing); }
    else {
      $t = Term::create(["vid" => "trc_topics", "name" => $name]); $t->save();
      $terms[$name] = $t;
    }
  }
  if (!FieldStorageConfig::loadByName("node", "field_trc_topic")) {
    FieldStorageConfig::create([
      "field_name" => "field_trc_topic", "entity_type" => "node",
      "type" => "entity_reference", "settings" => ["target_type" => "taxonomy_term"],
      "cardinality" => 1,
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_trc_topic")) {
    FieldConfig::create([
      "field_name" => "field_trc_topic", "entity_type" => "node", "bundle" => "article",
      "label" => "TRC Topic",
      "settings" => ["handler" => "default:taxonomy_term", "handler_settings" => ["target_bundles" => ["trc_topics" => "trc_topics"]]],
    ])->save();
  }
' >/dev/null 2>&1
# Second request: field definitions are now fresh, so the nodes can carry the new field.
drush php:eval '
  use Drupal\node\Entity\Node;
  $ts = \Drupal::entityTypeManager()->getStorage("taxonomy_term");
  $alpha = reset($ts->loadByProperties(["vid" => "trc_topics", "name" => "Alpha"]));
  $storage = \Drupal::entityTypeManager()->getStorage("node");
  foreach (["TRC Known One", "TRC Known Two"] as $title) {
    $found = $storage->loadByProperties(["title" => $title]);
    $n = $found ? reset($found) : Node::create(["type" => "article", "title" => $title]);
    $n->set("field_trc_topic", $alpha->id());
    $n->save();
  }
  print "alpha_tid=" . $alpha->id() . "\n";
' 2>&1 | tail -1
drush cr >/dev/null 2>&1
echo "setup: trc_topics vocabulary + field_trc_topic on article + 2 articles referencing Alpha"
