#!/usr/bin/env bash
# Execution VERIFY: PASS when a webform_content_creator config entity maps webform 'contact' to
# node/article. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("webform_content_creator");
  $ok = FALSE; $id = "none";
  foreach ($s->loadMultiple() as $e) {
    if (($e->get("webform")??"")==="contact" && ($e->get("target_entity_type")??"")==="node" && ($e->get("target_bundle")??"")==="article") { $ok = TRUE; $id = $e->id(); break; }
  }
  print ($ok ? "PASS" : "FAIL") . " match=" . $id . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
