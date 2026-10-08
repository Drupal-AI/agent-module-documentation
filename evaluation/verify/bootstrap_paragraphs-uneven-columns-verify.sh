#!/usr/bin/env bash
# Execution VERIFY for "build a two-uneven-columns Bootstrap Paragraph".
# PASS when the "BP Hard Uneven Page" article references a bp_columns_two_uneven paragraph with
#   bp_column_style_2 = paragraph--style--66-33   (the "2/3 - 1/3" option)
#   bp_column_content_2 holding exactly 2 child paragraphs, both of bundle bp_simple
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\node\Entity\Node;

  $ids = \Drupal::entityQuery("node")->accessCheck(FALSE)
    ->condition("title", "BP Hard Uneven Page")->execute();
  if (!$ids) { print "FAIL node \"BP Hard Uneven Page\" not found\n"; return; }
  $n = Node::load(reset($ids));
  if (!$n->hasField("field_bp_uneven_sections") || $n->get("field_bp_uneven_sections")->isEmpty()) {
    print "FAIL field_bp_uneven_sections is empty\n"; return;
  }

  $col = NULL;
  foreach ($n->get("field_bp_uneven_sections") as $item) {
    $p = $item->entity;
    if ($p && $p->bundle() === "bp_columns_two_uneven") { $col = $p; break; }
  }
  if (!$col) { print "FAIL no bp_columns_two_uneven paragraph referenced\n"; return; }

  $style = $col->hasField("bp_column_style_2") ? (string) $col->bp_column_style_2->value : "";

  $kids = [];
  if ($col->hasField("bp_column_content_2")) {
    foreach ($col->get("bp_column_content_2") as $child) {
      $kids[] = $child->entity ? $child->entity->bundle() : "missing";
    }
  }

  $ok = ($style === "paragraph--style--66-33")
    && (count($kids) === 2)
    && ($kids === ["bp_simple", "bp_simple"]);

  print ($ok ? "PASS" : "FAIL")
    . " style=" . ($style !== "" ? $style : "none")
    . " children=" . count($kids)
    . " [" . implode(",", $kids) . "]\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
