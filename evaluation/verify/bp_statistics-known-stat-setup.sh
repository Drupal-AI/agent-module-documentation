#!/usr/bin/env bash
# Introspection SETUP for bp_statistics: attach a Paragraphs field field_bpstat_a to
# node.article restricted to the bp_statistics bundle, and create the article
# "BP Statistics Eval Node" holding one Statistics paragraph with THREE nested bp_stat
# children with known values. The agent must read the live nested paragraphs to report the
# Statistic value belonging to the stat whose header is "Uptime". Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html

drush php:eval '
  use Drupal\node\Entity\Node;
  $ids = \Drupal::entityQuery("node")->accessCheck(FALSE)
    ->condition("title", "BP Statistics Eval Node")->execute();
  if ($ids) { \Drupal::entityTypeManager()->getStorage("node")->delete(Node::loadMultiple($ids)); }
' >/dev/null 2>&1

drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_bpstat_a")) {
    FieldStorageConfig::create([
      "field_name" => "field_bpstat_a", "entity_type" => "node",
      "type" => "entity_reference_revisions", "cardinality" => -1,
      "settings" => ["target_type" => "paragraph"],
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_bpstat_a")) {
    FieldConfig::create([
      "field_name" => "field_bpstat_a", "entity_type" => "node",
      "bundle" => "article", "label" => "BP Statistics Band",
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
  $rows = [
    ["Uptime", "99.98%", "Rolling 12 months"],
    ["Customers", "4,200", "Across 30 countries"],
    ["Response", "under 2h", "Median first reply"],
  ];
  $stats = [];
  foreach ($rows as [$h, $i, $d]) {
    $s = Paragraph::create([
      "type" => "bp_stat",
      "bp_statistic_header" => $h,
      "bp_statistic_item" => $i,
      "bp_statistic_description" => $d,
    ]);
    $s->save();
    $stats[] = $s;
  }
  $band = Paragraph::create([
    "type" => "bp_statistics",
    "bp_header" => "By The Numbers",
    "bp_width" => "paragraph--width--medium",
    "bp_statistic" => $stats,
  ]);
  $band->save();
  Node::create([
    "type" => "article", "title" => "BP Statistics Eval Node", "status" => 1,
    "field_bpstat_a" => [$band],
  ])->save();
' >/dev/null 2>&1

drush cr >/dev/null 2>&1
echo "setup: node 'BP Statistics Eval Node' has a bp_statistics paragraph with 3 bp_stat children (Uptime=99.98%)"
