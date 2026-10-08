#!/usr/bin/env bash
# Execution RESET for the "migrate ONLY one node" case. Builds the trc_limit vocabulary
# with "Legacy Tag" / "Current Tag", a taxonomy term reference field field_trc_limit on
# Article, and three Articles ("TRC Limit Keep 1", "TRC Limit Keep 2", "TRC Limit Move")
# all referencing "Legacy Tag". Verify FAILS in this state. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  use Drupal\taxonomy\Entity\Term;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\node\Entity\Node;
  if (!Vocabulary::load("trc_limit")) {
    Vocabulary::create(["vid" => "trc_limit", "name" => "TRC Limit"])->save();
  }
  $terms = [];
  foreach (["Legacy Tag", "Current Tag"] as $name) {
    $existing = \Drupal::entityTypeManager()->getStorage("taxonomy_term")
      ->loadByProperties(["vid" => "trc_limit", "name" => $name]);
    if ($existing) { $terms[$name] = reset($existing); }
    else { $t = Term::create(["vid" => "trc_limit", "name" => $name]); $t->save(); $terms[$name] = $t; }
  }
  if (!FieldStorageConfig::loadByName("node", "field_trc_limit")) {
    FieldStorageConfig::create([
      "field_name" => "field_trc_limit", "entity_type" => "node",
      "type" => "entity_reference", "settings" => ["target_type" => "taxonomy_term"],
      "cardinality" => 1,
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_trc_limit")) {
    FieldConfig::create([
      "field_name" => "field_trc_limit", "entity_type" => "node", "bundle" => "article",
      "label" => "TRC Limit Tag",
      "settings" => ["handler" => "default:taxonomy_term", "handler_settings" => ["target_bundles" => ["trc_limit" => "trc_limit"]]],
    ])->save();
  }
' >/dev/null 2>&1
# Second request: field definitions are now fresh, so the nodes can carry the new field.
drush php:eval '
  use Drupal\node\Entity\Node;
  $ts = \Drupal::entityTypeManager()->getStorage("taxonomy_term");
  $legacy = reset($ts->loadByProperties(["vid" => "trc_limit", "name" => "Legacy Tag"]));
  $storage = \Drupal::entityTypeManager()->getStorage("node");
  foreach (["TRC Limit Keep 1", "TRC Limit Keep 2", "TRC Limit Move"] as $title) {
    $found = $storage->loadByProperties(["title" => $title]);
    $n = $found ? reset($found) : Node::create(["type" => "article", "title" => $title]);
    $n->set("field_trc_limit", $legacy->id());
    $n->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: 3 articles reference 'Legacy Tag' in field_trc_limit"
