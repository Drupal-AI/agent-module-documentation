#!/usr/bin/env bash
# Introspection SETUP for bp_statistics: attach field_bpstat_b to node.article (restricted to
# bp_statistics) and create the article "BP Statistics Background Node" holding a Statistics
# paragraph with a KNOWN bp_background value (paragraph--color paragraph--color--info) and
# two nested bp_stat children. The agent must read the live paragraph to report the stored
# background value. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html

drush php:eval '
  use Drupal\node\Entity\Node;
  $ids = \Drupal::entityQuery("node")->accessCheck(FALSE)
    ->condition("title", "BP Statistics Background Node")->execute();
  if ($ids) { \Drupal::entityTypeManager()->getStorage("node")->delete(Node::loadMultiple($ids)); }
' >/dev/null 2>&1

drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_bpstat_b")) {
    FieldStorageConfig::create([
      "field_name" => "field_bpstat_b", "entity_type" => "node",
      "type" => "entity_reference_revisions", "cardinality" => -1,
      "settings" => ["target_type" => "paragraph"],
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_bpstat_b")) {
    FieldConfig::create([
      "field_name" => "field_bpstat_b", "entity_type" => "node",
      "bundle" => "article", "label" => "BP Statistics Background Band",
      "settings" => [
        "handler" => "default:paragraph",
        "handler_settings" => ["target_bundles" => ["bp_statistics" => "bp_statistics"]],
      ],
    ])->save();
  }
' >/dev/null 2>&1

drush php:eval '
  use Drupal\node\Entity\Node;
  use Drupal\paragraphs\Entity\Paragraph;
  $stats = [];
  foreach ([["Sites", "1,050"], ["Regions", "12"]] as [$h, $i]) {
    $s = Paragraph::create([
      "type" => "bp_stat", "bp_statistic_header" => $h, "bp_statistic_item" => $i,
    ]);
    $s->save();
    $stats[] = $s;
  }
  $band = Paragraph::create([
    "type" => "bp_statistics",
    "bp_header" => "Coverage",
    "bp_background" => "paragraph--color paragraph--color--info",
    "bp_statistic" => $stats,
  ]);
  $band->save();
  Node::create([
    "type" => "article", "title" => "BP Statistics Background Node", "status" => 1,
    "field_bpstat_b" => [$band],
  ])->save();
' >/dev/null 2>&1

drush cr >/dev/null 2>&1
echo "setup: 'BP Statistics Background Node' bp_statistics paragraph has bp_background='paragraph--color paragraph--color--info'"
