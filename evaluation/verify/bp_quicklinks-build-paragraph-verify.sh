#!/usr/bin/env bash
# Execution VERIFY for bp_quicklinks "build a Quicklinks paragraph on a node".
# PASS when an article titled "BP Quicklinks Task" exists and its field_bpquick_menu holds a
# paragraph of bundle bp_quicklinks with:
#   - bp_header  === "Quick Links"
#   - bp_width   === "paragraph--width--wide"
#   - at least 2 bp_quick_link items, including one pointing at drupal.org
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\node\Entity\Node;
  $ids = \Drupal::entityQuery("node")->accessCheck(FALSE)
    ->condition("title", "BP Quicklinks Task")->execute();
  if (!$ids) { print "FAIL node=missing\n"; return; }
  $node = Node::load(reset($ids));
  if (!$node->hasField("field_bpquick_menu")) { print "FAIL field=missing\n"; return; }
  $paras = $node->get("field_bpquick_menu")->referencedEntities();
  $target = NULL;
  foreach ($paras as $p) { if ($p->bundle() === "bp_quicklinks") { $target = $p; break; } }
  if (!$target) { print "FAIL paragraph=none-of-bundle-bp_quicklinks\n"; return; }
  $header = $target->hasField("bp_header") ? (string) $target->get("bp_header")->value : "";
  $width = $target->hasField("bp_width") ? (string) $target->get("bp_width")->value : "";
  $links = $target->hasField("bp_quick_link") ? $target->get("bp_quick_link")->getValue() : [];
  $uris = array_column($links, "uri");
  $has_drupal = (bool) array_filter($uris, fn($u) => stripos($u, "drupal.org") !== FALSE);
  $ok = $header === "Quick Links"
    && $width === "paragraph--width--wide"
    && count($links) >= 2
    && $has_drupal;
  print ($ok ? "PASS" : "FAIL")
    . " header=" . var_export($header, TRUE)
    . " width=" . var_export($width, TRUE)
    . " links=" . count($links)
    . " drupal_org=" . var_export($has_drupal, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
