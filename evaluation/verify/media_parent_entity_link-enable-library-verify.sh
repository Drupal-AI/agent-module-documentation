#!/usr/bin/env bash
# Execution VERIFY: PASS when media.image.media_library thumbnail has
# third_party_settings.media_parent_entity_link.link_to_parent set to a truthy flag. Exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("media.image.media_library");
  $c = $vd ? $vd->getComponent("thumbnail") : NULL;
  $v = $c["third_party_settings"]["media_parent_entity_link"]["link_to_parent"] ?? NULL;
  $ok = !empty($v);
  print ($ok ? "PASS" : "FAIL") . " field=thumbnail link_to_parent=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
