#!/usr/bin/env bash
# Execution VERIFY: PASS when a media type mes_podcast exists using the soundcloud source with a
# real source field configured. Exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\media\Entity\MediaType;
  use Drupal\field\Entity\FieldConfig;
  $t = MediaType::load("mes_podcast");
  $src = $t ? $t->getSource()->getPluginId() : "none";
  $sf = $t ? ($t->get("source_configuration")["source_field"] ?? "") : "";
  $exists = ($t && $sf && FieldConfig::loadByName("media", "mes_podcast", $sf)) ? TRUE : FALSE;
  $ok = ($t && $src === "soundcloud" && $sf && $exists);
  print ($ok ? "PASS" : "FAIL") . " source=" . $src . " source_field=" . ($sf ?: "none") . " field_exists=" . var_export($exists, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
