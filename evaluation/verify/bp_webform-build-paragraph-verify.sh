#!/usr/bin/env bash
# Execution VERIFY for bp_webform "embed a webform in a page".
# PASS when an article titled "BP Webform Task" exists and its field_bpwf_slot holds a
# paragraph of bundle bp_webform whose:
#   - bp_webform target_id  === "bpwf_task_form"
#   - bp_width              === "paragraph--width--medium"
#   - bp_background         === "paragraph--color paragraph--color--info"
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\node\Entity\Node;
  $ids = \Drupal::entityQuery("node")->accessCheck(FALSE)
    ->condition("title", "BP Webform Task")->execute();
  if (!$ids) { print "FAIL node=missing\n"; return; }
  $node = Node::load(reset($ids));
  if (!$node->hasField("field_bpwf_slot")) { print "FAIL field=missing\n"; return; }
  $para = NULL;
  foreach ($node->get("field_bpwf_slot")->referencedEntities() as $p) {
    if ($p->bundle() === "bp_webform") { $para = $p; break; }
  }
  if (!$para) { print "FAIL paragraph=none-of-bundle-bp_webform\n"; return; }
  $target = (string) ($para->get("bp_webform")->target_id ?? "");
  $width = (string) $para->get("bp_width")->value;
  $bg = (string) $para->get("bp_background")->value;
  $ok = $target === "bpwf_task_form"
    && $width === "paragraph--width--medium"
    && $bg === "paragraph--color paragraph--color--info";
  print ($ok ? "PASS" : "FAIL")
    . " webform=" . var_export($target, TRUE)
    . " width=" . var_export($width, TRUE)
    . " background=" . var_export($bg, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
