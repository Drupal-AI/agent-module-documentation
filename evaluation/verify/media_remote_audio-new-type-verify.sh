#!/usr/bin/env bash
# Execution VERIFY: PASS when media type mra_podcast exists, uses source plugin oembed:audio,
# and has a real source field on the media entity. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $t = \Drupal::entityTypeManager()->getStorage("media_type")->load("mra_podcast");
  if (!$t) { print "FAIL no-type\n"; return; }
  $src = $t->getSource();
  $pid = $src->getPluginId();
  $sf = $t->get("source_configuration")["source_field"] ?? "";
  $has_field = ($sf && \Drupal\field\Entity\FieldConfig::loadByName("media", "mra_podcast", $sf)) ? "yes" : "no";
  $ok = ($pid === "oembed:audio" && $has_field === "yes");
  print ($ok ? "PASS" : "FAIL") . " source=" . $pid . " source_field=" . ($sf ?: "none") . " field_exists=" . $has_field . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
