#!/usr/bin/env bash
# Execution VERIFY (bp_media): PASS when an article titled "BP Media Build Target" has, in
# field_bpmedia_build, a bp_media paragraph that references the media entity named
# "BP Media Build Image", with bp_header = "Product Gallery" and
# bp_width = paragraph--width--full. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\node\Entity\Node;
  $ids = \Drupal::entityQuery("node")->accessCheck(FALSE)->condition("title", "BP Media Build Target")->execute();
  $ok = FALSE; $detail = "no node";
  foreach (Node::loadMultiple($ids) as $n) {
    if (!$n->hasField("field_bpmedia_build")) { $detail = "node has no field_bpmedia_build"; continue; }
    foreach ($n->get("field_bpmedia_build")->referencedEntities() as $p) {
      if ($p->bundle() !== "bp_media") { $detail = "wrong bundle " . $p->bundle(); continue; }
      $m = $p->get("bp_media")->entity;
      $mediaName = $m ? $m->label() : NULL;
      $header = $p->get("bp_header")->value;
      $width = $p->get("bp_width")->value;
      $detail = "media=" . var_export($mediaName, TRUE) . " header=" . var_export($header, TRUE) . " width=" . var_export($width, TRUE);
      if ($mediaName === "BP Media Build Image" && $header === "Product Gallery"
          && $width === "paragraph--width--full") { $ok = TRUE; break 2; }
    }
  }
  print ($ok ? "PASS" : "FAIL") . " " . $detail . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
