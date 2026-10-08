#!/usr/bin/env bash
# Execution VERIFY for "add a styled bp_simple paragraph to the BP Hard Styled Page article".
# PASS when that node's field_bp_hard_sections references a paragraph of bundle bp_simple with
#   bp_header     = "Hello Bootstrap"
#   bp_width      = paragraph--width--narrow          (Narrow)
#   bp_background = paragraph--color paragraph--color--primary   (Brand Primary Color)
#   bp_margin     = mt-5 mb-5                          (Top and Bottom Large)
#   bp_text       non-empty
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\node\Entity\Node;

  $ids = \Drupal::entityQuery("node")->accessCheck(FALSE)
    ->condition("title", "BP Hard Styled Page")->execute();
  if (!$ids) { print "FAIL node \"BP Hard Styled Page\" not found\n"; return; }
  $n = Node::load(reset($ids));
  if (!$n->hasField("field_bp_hard_sections") || $n->get("field_bp_hard_sections")->isEmpty()) {
    print "FAIL field_bp_hard_sections is empty\n"; return;
  }

  $found = NULL;
  foreach ($n->get("field_bp_hard_sections") as $item) {
    $p = $item->entity;
    if ($p && $p->bundle() === "bp_simple") { $found = $p; break; }
  }
  if (!$found) { print "FAIL no bp_simple paragraph referenced\n"; return; }

  $header = $found->hasField("bp_header") ? (string) $found->bp_header->value : "";
  $width  = $found->hasField("bp_width") ? (string) $found->bp_width->value : "";
  $bg     = $found->hasField("bp_background") ? (string) $found->bp_background->value : "";
  $margin = $found->hasField("bp_margin") ? (string) $found->bp_margin->value : "";
  $text   = $found->hasField("bp_text") ? trim((string) $found->bp_text->value) : "";

  $ok = (trim($header) === "Hello Bootstrap")
    && ($width === "paragraph--width--narrow")
    && ($bg === "paragraph--color paragraph--color--primary")
    && ($margin === "mt-5 mb-5")
    && ($text !== "");

  print ($ok ? "PASS" : "FAIL")
    . " header=\"" . $header . "\""
    . " width=" . $width
    . " bg=\"" . $bg . "\""
    . " margin=\"" . $margin . "\""
    . " text_len=" . strlen($text) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
