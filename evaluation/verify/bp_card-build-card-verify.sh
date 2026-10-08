#!/usr/bin/env bash
# Execution VERIFY (bp_card): PASS when an article titled "BP Card Build Target" has, in
# field_bpcard_build, a bp_card paragraph with bp_card_title = "Annual Report",
# bp_card_style = card--large-top, bp_card_button_style = "btn btn-success" and
# bp_link_entire_card = TRUE. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\node\Entity\Node;
  $ids = \Drupal::entityQuery("node")->accessCheck(FALSE)->condition("title", "BP Card Build Target")->execute();
  $ok = FALSE; $detail = "no node";
  foreach (Node::loadMultiple($ids) as $n) {
    if (!$n->hasField("field_bpcard_build")) { $detail = "node has no field_bpcard_build"; continue; }
    foreach ($n->get("field_bpcard_build")->referencedEntities() as $p) {
      if ($p->bundle() !== "bp_card") { $detail = "wrong bundle " . $p->bundle(); continue; }
      $title = $p->get("bp_card_title")->value;
      $style = $p->get("bp_card_style")->value;
      $btn = $p->get("bp_card_button_style")->value;
      $entire = (bool) $p->get("bp_link_entire_card")->value;
      $detail = "title=" . var_export($title, TRUE) . " style=" . var_export($style, TRUE)
        . " button=" . var_export($btn, TRUE) . " entire=" . var_export($entire, TRUE);
      if ($title === "Annual Report" && $style === "card--large-top"
          && $btn === "btn btn-success" && $entire === TRUE) { $ok = TRUE; break 2; }
    }
  }
  print ($ok ? "PASS" : "FAIL") . " " . $detail . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
