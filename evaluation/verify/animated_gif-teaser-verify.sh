#!/usr/bin/env bash
# Execution VERIFY: PASS when image field field_ag_hero exists on Article AND the teaser view
# display renders it with the animated_gif_image_url formatter. Exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldConfig;
  if (!FieldConfig::loadByName("node","article","field_ag_hero")) { print "FAIL no-field\n"; return; }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.teaser");
  $c = $vd ? $vd->getComponent("field_ag_hero") : NULL;
  $t = $c["type"] ?? "none";
  print (($t === "animated_gif_image_url") ? "PASS" : "FAIL") . " teaser_formatter=" . $t . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
