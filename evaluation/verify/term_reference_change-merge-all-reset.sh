#!/usr/bin/env bash
# Execution RESET for the "merge every reference from Old Topic to New Topic" case.
# Builds the trc_merge vocabulary with terms "Old Topic" and "New Topic", a multi-value
# taxonomy term reference field field_trc_merge on Article, and three Articles that all
# reference ONLY "Old Topic" — so verify FAILS until the agent migrates them. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  use Drupal\taxonomy\Entity\Term;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\node\Entity\Node;
  if (!Vocabulary::load("trc_merge")) {
    Vocabulary::create(["vid" => "trc_merge", "name" => "TRC Merge"])->save();
  }
  $terms = [];
  foreach (["Old Topic", "New Topic"] as $name) {
    $existing = \Drupal::entityTypeManager()->getStorage("taxonomy_term")
      ->loadByProperties(["vid" => "trc_merge", "name" => $name]);
    if ($existing) { $terms[$name] = reset($existing); }
    else { $t = Term::create(["vid" => "trc_merge", "name" => $name]); $t->save(); $terms[$name] = $t; }
  }
  if (!FieldStorageConfig::loadByName("node", "field_trc_merge")) {
    FieldStorageConfig::create([
      "field_name" => "field_trc_merge", "entity_type" => "node",
      "type" => "entity_reference", "settings" => ["target_type" => "taxonomy_term"],
      "cardinality" => -1,
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_trc_merge")) {
    FieldConfig::create([
      "field_name" => "field_trc_merge", "entity_type" => "node", "bundle" => "article",
      "label" => "TRC Merge Topic",
      "settings" => ["handler" => "default:taxonomy_term", "handler_settings" => ["target_bundles" => ["trc_merge" => "trc_merge"]]],
    ])->save();
  }
' >/dev/null 2>&1
# Second request: field definitions are now fresh, so the nodes can carry the new field.
drush php:eval '
  use Drupal\node\Entity\Node;
  $ts = \Drupal::entityTypeManager()->getStorage("taxonomy_term");
  $old = reset($ts->loadByProperties(["vid" => "trc_merge", "name" => "Old Topic"]));
  $new = reset($ts->loadByProperties(["vid" => "trc_merge", "name" => "New Topic"]));
  $storage = \Drupal::entityTypeManager()->getStorage("node");
  foreach (["TRC Merge A", "TRC Merge B", "TRC Merge C"] as $title) {
    $found = $storage->loadByProperties(["title" => $title]);
    $n = $found ? reset($found) : Node::create(["type" => "article", "title" => $title]);
    $n->set("field_trc_merge", [["target_id" => $old->id()]]);
    $n->save();
  }
  print "old_tid=" . $old->id() . " new_tid=" . $new->id() . "\n";
' 2>&1 | tail -1
drush cr >/dev/null 2>&1
echo "reset: 3 articles reference the 'Old Topic' term in field_trc_merge"
