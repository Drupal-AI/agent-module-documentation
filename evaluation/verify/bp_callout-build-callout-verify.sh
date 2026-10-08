#!/usr/bin/env bash
# Execution VERIFY (bp_callout): PASS when an article node titled "BP Callout Build Target"
# has, in field_bpcallout_build, a paragraph of bundle bp_callout with
# bp_callout_style = callout-style--danger and bp_header = "Safety Notice".
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\node\Entity\Node;
  $ids = \Drupal::entityQuery("node")->accessCheck(FALSE)->condition("title", "BP Callout Build Target")->execute();
  $ok = FALSE; $detail = "no node";
  foreach (Node::loadMultiple($ids) as $n) {
    if (!$n->hasField("field_bpcallout_build")) { $detail = "node has no field_bpcallout_build"; continue; }
    foreach ($n->get("field_bpcallout_build")->referencedEntities() as $p) {
      $style = $p->hasField("bp_callout_style") ? $p->get("bp_callout_style")->value : NULL;
      $header = $p->hasField("bp_header") ? $p->get("bp_header")->value : NULL;
      $detail = "bundle=" . $p->bundle() . " style=" . var_export($style, TRUE) . " header=" . var_export($header, TRUE);
      if ($p->bundle() === "bp_callout" && $style === "callout-style--danger" && $header === "Safety Notice") { $ok = TRUE; break 2; }
    }
  }
  print ($ok ? "PASS" : "FAIL") . " " . $detail . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
